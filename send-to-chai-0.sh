#!/bin/bash

directory=$1
pattern="*.pdb"

for file in "$directory"/$pattern; do
  if [ -f "$file" ]; then
   filename=$(basename -- "$file")
   extension="${filename##*.}"
   prefixfile="${filename%.*}"
   fastafile="$prefixfile".fa 
   chaidir="$directory"_chai"/"$prefixfile
   /home/nmrbox/ldonaldson/software/chaipdb2fasta.pl $file > $fastafile
  
 #  echo $fastafile $chaidir
   python run-chai-0.py $fastafile $chaidir 
   rm $fastafile
  fi
done
