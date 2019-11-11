#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=sort_%j
#SBATCH --output=sort_%j.log
#SBATCH --mem=100GB #MB
###sort_index.sh
#sbatch sort_index.sh ../rawdata/wgr_peer_individuals.txt 

cd ~/wgr_peromyscus/goodbam
module purge

SAMPLELIST=$1
for SAMPLE in `cat $SAMPLELIST`; do

samtools sort -@24 $SAMPLE.sorted.bam ~/wgr_peromyscus/bamfiles/$SAMPLE.clean.bam

samtools index $SAMPLE.sorted.bam
done
