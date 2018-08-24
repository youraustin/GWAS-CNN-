curve_type="Cantor  Hilbert  Row  RowPrime  Spiral"
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

src=./oversampling/$szt/$ct/train_unctrl
opj=./datasets/$szt/FinalFeatureSelection1024_p"$pt"_e"$et"_seed"$st"_k"$kt"/$ct

cp -R $src $opj

done
done
done
done
done
msg3="$ct had been finished over"
echo $msg3
done
