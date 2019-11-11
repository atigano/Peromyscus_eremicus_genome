!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=merge_%j
#SBATCH --output=merge_%j.log
#SBATCH --mem=100GB #MB
###mergebams.sh
#sbatch mergebams.sh ../rawdata/wgr_peer_individuals.txt 

cd ~/wgr_peromyscus/bamfiles
module purge

SAMPLELIST=$1
for SAMPLE in `cat $SAMPLELIST`; do

DEDUPS=$(ls ${SAMPLE}_*.bam)

samtools merge -@24 -u - $DEDUPS | samtools view -F 0x4 -b - > $SAMPLE.clean.bam

done
