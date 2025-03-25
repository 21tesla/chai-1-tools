#!/bin/csh


#usage:   get_top_10.csh project_mpnn_chai
#output:  scores.txt and a directoy of the top 10

python extract_chai.py {$1}_mpnn_chai | sort -n +6 -r > scores.txt
head -10 scores.txt > top10.txt

cd {$1}_mpnn_chai
mkdir best 

awk '{ printf ("cp %s/pred.model_idx_0.cif best/best_%d.cif\n",$1,NR); } ' ../top10.txt > temp2.csh
csh temp2.csh
cd ..
mkdir {$1}_best
mv {$1}_mpnn_chai/best/* {$1}_best
rm -rf {$1}_mpnn_chai/best {$1}_mpnn_chai/temp2.csh
mv top10.txt {$1}_best
mv scores.txt {$1}_best
