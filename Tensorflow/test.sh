curve_type="Cantor"  #Hilbert  Cantor  Row  RowPrime  Spiral
size_type="32 64 128 256"
p_type="20 30 40 50"
e_type="2 3 4"
seed_type="1 3 5 7"
k_type="5 7 9 11"
for szt in $size_type; do
for ct in $curve_type; do
for pt in $p_type;do
for et in $e_type; do
for st in $seed_type; do
for kt in $k_type; do
dbname=$szt/FinalFeatureSelection1024_p"$pt"_e"$et"_seed"$st"_k"$kt"/$ct
#python main.py --dataset_name $dbname --phase train --batch_size 10 --image_size $szt
python main.py --dataset_name $dbname --phase test --batch_size 10 --image_size $szt
done
done
done
done
done
done
#python main.py --dataset_name 32/FinalFeatureSelection1024_p40_e3_seed3_k7/Cantor --phase train --batch_size 10 --image_size 32

#Hilbert test
#python main.py --dataset_name Hilbert --phase test --batch_size 10 --image_size 256


#Cantor train
#python main.py --dataset_name Cantor --phase train --batch_size 10 --image_size 256

#Cantor test
#python main.py --dataset_name Cantor --phase test 

#./test.sh>test-all2.out

