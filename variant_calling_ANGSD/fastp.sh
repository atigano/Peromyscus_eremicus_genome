#!/bin/bash
#SBATCH --partition=shared,macmanes
q#SBATCH --job-name=fastp_%j
#SBATCH --output=fastp_%j.log
#SBATCH --mem=100GB #MB
###fastp.sh
#sbatch fastp.sh samplelist

SAMPLELIST=$1
for SAMPLE in `cat $SAMPLELIST`; do

fastp -i ${SAMPLE}_1.fq.gz -I ${SAMPLE}_2.fq.gz -o ${SAMPLE}_trimmed_1.fq.gz -O ${SAMPLE}_trimmed_2.fq.gz --adapter_sequence CTGTCTCTTATACACATCT --adapter_sequence_r2 CTGTCTCTTATACACATCT --trim_poly_g -Q -h ${SAMPLE}.html

done
