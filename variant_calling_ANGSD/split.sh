#!/bin/bash
#SBATCH --partition=shared,macmanes

#SBATCH --job-name=split_%j
#SBATCH --output=split_%j.log
#SBATCH --mem=100GB #MB
###split.sh
#sbatch split.sh samplelist

SAMPLELIST=$1
for SAMPLE in `cat $SAMPLELIST`; do

gzip -cd ${SAMPLE}_trimmed_1.fq.gz | split -a 3 -l 28000000 -d --additional-suffix=.fastq - ${SAMPLE}_R1_ 
gzip -cd ${SAMPLE}_trimmed_2.fq.gz | split -a 3 -l 28000000 -d --additional-suffix=.fastq - ${SAMPLE}_R2_ 

done
