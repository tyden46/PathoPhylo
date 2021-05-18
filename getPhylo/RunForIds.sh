#!/bin/bash
while read a; do 
  list+=($a)
done < SubsetOfGenomes.txt
printf ID
printf '\t'
printf taxa
printf '\t'
printf rank
printf '\n'
for ID in "${list[@]}"; do
  #echo bash NCBI_ID_to_Lineage.sh $ID
  bash NCBI_ID_to_Lineage.sh $ID
done
