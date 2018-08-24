from __future__ import division
import os
import time
from glob import glob
import tensorflow as tf
import numpy as np
from six.moves import xrange

from ops import *
from utils import *

class dna(object):
    def __init__(self, sess, image_size=256,
                 batch_size=10, df_dim=64, 
                 input_c_dim=3, dataset_name='Hilbert',
                 checkpoint_dir=None):

        self.sess = sess
        self.batch_size = batch_size
        self.image_size = image_size


        self.input_c_dim = input_c_dim
        self.df_dim = df_dim

        # batch normalization : deals with poor initialization helps gradient flow
        self.d_bn1 = batch_norm(name='d_bn1')
        self.d_bn2 = batch_norm(name='d_bn2')
        self.d_bn3 = batch_norm(name='d_bn3')

        self.dataset_name = dataset_name
        self.checkpoint_dir = checkpoint_dir
        self.build_model()

    def build_model(self):
        self.inputs = tf.placeholder(tf.float32,
                                        [self.batch_size, self.image_size, self.image_size,
                                         self.input_c_dim],
                                        name='input_img')

        self.labels = tf.placeholder(tf.float32,
                                        [self.batch_size, 1],
                                        name='label')

        self.preds= self.discriminator(self.inputs, self.image_size, reuse=False)

        self.pred_sum = tf.summary.histogram("preds", self.preds)

        self.loss = tf.reduce_mean(tf.nn.sigmoid_cross_entropy_with_logits(logits=self.preds, labels=self.labels))

        self.loss_sum = tf.summary.scalar("loss", self.loss)

        self.t_vars = tf.trainable_variables()
        self.saver = tf.train.Saver()

    def train(self, args):
        """Train dna"""
        optim = tf.train.AdamOptimizer(args.lr, beta1=args.beta1) \
                          .minimize(self.loss, var_list=self.t_vars)

        init_op = tf.global_variables_initializer()
        self.sess.run(init_op)

        self.sum = tf.summary.merge([self.pred_sum,
            self.loss_sum])
        self.writer = tf.summary.FileWriter("./logs", self.sess.graph)

        counter = 1
        start_time = time.time()

        if self.load(self.checkpoint_dir):
            print(" [*] Load SUCCESS")
        else:
            print(" [!] Load failed...")

        for epoch in xrange(args.epoch):
            data_ctrl = glob('./datasets/{}/train_ctrl/*.png'.format(self.dataset_name))
            data_unctrl = glob('./datasets/{}/train_unctrl/*.png'.format(self.dataset_name))
            np.random.shuffle(data_ctrl)
            np.random.shuffle(data_unctrl)
            half_bs = self.batch_size //2
            batch_idxs = min(len(data_ctrl), len(data_unctrl)) // half_bs
            print("#images control loaded: ", len(data_ctrl))
            print("#images uncontrol loaded:", len(data_unctrl))
            print("#batches/epoch", batch_idxs)

            for idx in xrange(0, batch_idxs):
                batch_files = data_ctrl[idx*half_bs:(idx+1)*half_bs]
                batch_files = batch_files + data_unctrl[idx*half_bs:(idx+1)*half_bs]
                batch = [load_data(batch_file) for batch_file in batch_files]
                batch_images = np.array(batch).astype(np.float32)[:, :, :, None]
                batch_images = np.reshape(batch_images,(self.batch_size,self.image_size,self.image_size,-1))
                labels = np.concatenate((np.ones((half_bs,1),dtype=np.float32), \
                np.zeros((half_bs,1),dtype = np.float32)),0 )
                # Update network
                _, summary_str, loss_val = self.sess.run([optim, self.sum, self.loss],
                                               feed_dict={ self.inputs: batch_images, self.labels: labels})
                self.writer.add_summary(summary_str, counter)

                counter += 1
                print("Epoch: [%2d] [%4d/%4d] time: %4.4f, loss: %.8f" \
                    % (epoch, idx, batch_idxs,
                        time.time() - start_time, loss_val))
                        
                if np.mod(counter, 500) == 2:
                    self.save(args.checkpoint_dir, counter)

    def discriminator(self, image, img_size, y=None, reuse=False):

        with tf.variable_scope("discriminator") as scope:

            # image is 256 x 256 x (input_c_dim + output_c_dim)
            if reuse:
                tf.get_variable_scope().reuse_variables()
            else:
                assert tf.get_variable_scope().reuse == False
            if img_size >= 128:
                h0 = lrelu(conv2d(image, self.df_dim, name='d_h0_conv'))
                # h0 is (128 x 128 x self.df_dim)
                h1 = lrelu(self.d_bn1(conv2d(h0, self.df_dim*2, name='d_h1_conv')))
                # h1 is (64 x 64 x self.df_dim*2)
                h2 = lrelu(self.d_bn2(conv2d(h1, self.df_dim*4, name='d_h2_conv')))
                # h2 is (32x 32 x self.df_dim*4)
                h3 = lrelu(self.d_bn3(conv2d(h2, self.df_dim*8, d_h=1, d_w=1, name='d_h3_conv')))
                # h3 is (32 x 32 x self.df_dim*8)
                h4 = linear(tf.reshape(h3, [self.batch_size, -1]), 1, 'd_h3_lin')
            elif img_size == 32:
                h0 = lrelu(conv2d(image, self.df_dim, d_h=1, d_w=1, name='d_h0_conv'))
                # h0 is (64 x 64 x self.df_dim)
                h1 = lrelu(self.d_bn1(conv2d(h0, self.df_dim*2, name='d_h1_conv')))
                # h1 is (32 x 32 x self.df_dim*2)
                h2 = lrelu(self.d_bn2(conv2d(h1, self.df_dim*4,d_h=1, d_w=1, name='d_h2_conv')))
                # h2 is (32x 32 x self.df_dim*4)
                #h3 = lrelu(self.d_bn3(conv2d(h2, self.df_dim*8, d_h=1, d_w=1, name='d_h3_conv')))
                # h3 is (32 x 32 x self.df_dim*8)
                h4 = linear(tf.reshape(h2, [self.batch_size, -1]), 1, 'd_h3_lin')
            elif img_size == 64:
            	h0 = lrelu(conv2d(image, self.df_dim, d_h=1, d_w=1, name='d_h0_conv'))
                # h0 is (64 x 64 x self.df_dim)
                h1 = lrelu(self.d_bn1(conv2d(h0, self.df_dim*2, name='d_h1_conv')))
                # h1 is (32 x 32 x self.df_dim*2)
                h2 = lrelu(self.d_bn2(conv2d(h1, self.df_dim*4,d_h=1, d_w=1, name='d_h2_conv')))
                # h2 is (32x 32 x self.df_dim*4)
                h3 = lrelu(self.d_bn3(conv2d(h2, self.df_dim*8, name='d_h3_conv')))
                # h3 is (32 x 32 x self.df_dim*8)
                h4 = linear(tf.reshape(h3, [self.batch_size, -1]), 1, 'd_h3_lin')
            else:
            	raise("[Error] img_size must be 32, 64, 128, 256, 512 ...!") 
            return h4

    def generator(self, image, y=None):
        with tf.variable_scope("generator") as scope:

            s = self.output_size
            s2, s4, s8, s16, s32, s64, s128 = int(s/2), int(s/4), int(s/8), int(s/16), int(s/32), int(s/64), int(s/128)

            # image is (256 x 256 x input_c_dim)
            e1 = conv2d(image, self.gf_dim, name='g_e1_conv')
            # e1 is (128 x 128 x self.gf_dim)
            e2 = self.g_bn_e2(conv2d(lrelu(e1), self.gf_dim*2, name='g_e2_conv'))
            # e2 is (64 x 64 x self.gf_dim*2)
            e3 = self.g_bn_e3(conv2d(lrelu(e2), self.gf_dim*4, name='g_e3_conv'))
            # e3 is (32 x 32 x self.gf_dim*4)
            e4 = self.g_bn_e4(conv2d(lrelu(e3), self.gf_dim*8, name='g_e4_conv'))
            # e4 is (16 x 16 x self.gf_dim*8)
            e5 = self.g_bn_e5(conv2d(lrelu(e4), self.gf_dim*8, name='g_e5_conv'))
            # e5 is (8 x 8 x self.gf_dim*8)
            e6 = self.g_bn_e6(conv2d(lrelu(e5), self.gf_dim*8, name='g_e6_conv'))
            # e6 is (4 x 4 x self.gf_dim*8)
            e7 = self.g_bn_e7(conv2d(lrelu(e6), self.gf_dim*8, name='g_e7_conv'))
            # e7 is (2 x 2 x self.gf_dim*8)
            e8 = self.g_bn_e8(conv2d(lrelu(e7), self.gf_dim*8, name='g_e8_conv'))
            # e8 is (1 x 1 x self.gf_dim*8)

            self.d1, self.d1_w, self.d1_b = deconv2d(tf.nn.relu(e8),
                [self.batch_size, s128, s128, self.gf_dim*8], name='g_d1', with_w=True)
            d1 = tf.nn.dropout(self.g_bn_d1(self.d1), 0.5)
            d1 = tf.concat([d1, e7], 3)
            # d1 is (2 x 2 x self.gf_dim*8*2)

            self.d2, self.d2_w, self.d2_b = deconv2d(tf.nn.relu(d1),
                [self.batch_size, s64, s64, self.gf_dim*8], name='g_d2', with_w=True)
            d2 = tf.nn.dropout(self.g_bn_d2(self.d2), 0.5)
            d2 = tf.concat([d2, e6], 3)
            # d2 is (4 x 4 x self.gf_dim*8*2)

            self.d3, self.d3_w, self.d3_b = deconv2d(tf.nn.relu(d2),
                [self.batch_size, s32, s32, self.gf_dim*8], name='g_d3', with_w=True)
            d3 = tf.nn.dropout(self.g_bn_d3(self.d3), 0.5)
            d3 = tf.concat([d3, e5], 3)
            # d3 is (8 x 8 x self.gf_dim*8*2)

            self.d4, self.d4_w, self.d4_b = deconv2d(tf.nn.relu(d3),
                [self.batch_size, s16, s16, self.gf_dim*8], name='g_d4', with_w=True)
            d4 = self.g_bn_d4(self.d4)
            d4 = tf.concat([d4, e4], 3)
            # d4 is (16 x 16 x self.gf_dim*8*2)

            self.d5, self.d5_w, self.d5_b = deconv2d(tf.nn.relu(d4),
                [self.batch_size, s8, s8, self.gf_dim*4], name='g_d5', with_w=True)
            d5 = self.g_bn_d5(self.d5)
            d5 = tf.concat([d5, e3], 3)
            # d5 is (32 x 32 x self.gf_dim*4*2)

            self.d6, self.d6_w, self.d6_b = deconv2d(tf.nn.relu(d5),
                [self.batch_size, s4, s4, self.gf_dim*2], name='g_d6', with_w=True)
            d6 = self.g_bn_d6(self.d6)
            d6 = tf.concat([d6, e2], 3)
            # d6 is (64 x 64 x self.gf_dim*2*2)

            self.d7, self.d7_w, self.d7_b = deconv2d(tf.nn.relu(d6),
                [self.batch_size, s2, s2, self.gf_dim], name='g_d7', with_w=True)
            d7 = self.g_bn_d7(self.d7)
            d7 = tf.concat([d7, e1], 3)
            # d7 is (128 x 128 x self.gf_dim*1*2)

            self.d8, self.d8_w, self.d8_b = deconv2d(tf.nn.relu(d7),
                [self.batch_size, s, s, self.output_c_dim], name='g_d8', with_w=True)
            # d8 is (256 x 256 x output_c_dim)

            return tf.nn.tanh(self.d8)

   
    def save(self, checkpoint_dir, step):
        model_name="DNA256"
        self.model_dir = "%s_%s_%s" % ("-".join(self.dataset_name.split('/')), self.batch_size, self.image_size)
        checkpoint_dir = os.path.join(checkpoint_dir, self.model_dir)

        if not os.path.exists(checkpoint_dir):
            os.makedirs(checkpoint_dir)

        self.saver.save(self.sess,
                        os.path.join(checkpoint_dir, model_name),
                        global_step=step)

    def load(self, checkpoint_dir):
        print(" [*] Reading checkpoint...")

        self.model_dir = "%s_%s_%s" % ("-".join(self.dataset_name.split('/')), self.batch_size, self.image_size)
        checkpoint_dir = os.path.join(checkpoint_dir, self.model_dir)

        ckpt = tf.train.get_checkpoint_state(checkpoint_dir)
        if ckpt and ckpt.model_checkpoint_path:
            ckpt_name = os.path.basename(ckpt.model_checkpoint_path)
            self.saver.restore(self.sess, os.path.join(checkpoint_dir, ckpt_name))
            return True
        else:
            return False

    def test(self, args):
        """Test dna"""
        dir_ctrl = './datasets/{}/test_ctrl/*.png'.format(self.dataset_name)
        dir_unctrl = './datasets/{}/test_unctrl/*.png'.format(self.dataset_name)
        print("Image Size: %s " %(self.image_size))
        print("Feature Selection Sequence: %s " %(self.dataset_name))
        print('control: ')
        self.test_sub(dir_ctrl, type='ctrl')
        print('uncontrol: ')
        self.test_sub(dir_unctrl, type='unctrl')

    def test_sub(self, dir, type='ctrl'):
        ##initialize test data
        data = glob(dir)
        np.random.shuffle(data)
        batch_idxs = len(data) // self.batch_size

        ##initialize model
        init_op = tf.global_variables_initializer()
        self.sess.run(init_op)
        
        ##start testing
        start_time = time.time()
        if self.load(self.checkpoint_dir):
            print(" [*] Load SUCCESS")
        else:
            print(" [!] Load failed...")
        pred_sum=0
        num=0
        preds_all=[]
        for idx in xrange(0, batch_idxs):
            batch_files = data[idx*self.batch_size:(idx+1)*self.batch_size]
            batch = [load_data(batch_file) for batch_file in batch_files]
            batch_images = np.array(batch).astype(np.float32)[:, :, :, None]
            batch_images = np.reshape(batch_images,(self.batch_size,self.image_size,self.image_size,-1))
            labels = np.ones((self.batch_size,),dtype=np.float32)
            # Update network
            preds = self.sess.run([self.preds],feed_dict={ self.inputs: batch_images})
            preds = 1 / (1 + np.exp(-preds[0]))
            preds_all = preds_all + [preds]
            pred_sum += np.mean(abs(preds))
            num = num + np.sum(preds>0.5)
        preds_all = np.reshape(np.array(preds_all),(-1))
        total_num = batch_idxs*self.batch_size
        if type == 'ctrl':
            acc=num/total_num
            loss=(total_num-pred_sum)/batch_idxs
        else:
            acc=(total_num-num)/total_num
            loss = pred_sum/batch_idxs
        print("#samples:%10d  etc:%.2f  acc:%.8f  loss:%.8f  "%\
        (total_num, time.time()-start_time, acc, loss))
        np.savetxt(self.model_dir+'_'+type+'_logits.txt',preds_all)

        
