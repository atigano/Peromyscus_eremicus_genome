#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=sweep
#SBATCH --output=sweep_%j.log
#SBATCH --cpus-per-task=1
#SBATCH --mem=400GB #MB
#sweepfinder_prep.sh
#gunzip -c angsd_peer_global_noout_allvar.mafs.gz > angsd_peer_global_noout_allvar.mafs

awk '{print $0 "\t" $6*$7*2}' angsd_peer_global_noout_allvar.mafs | awk '{printf "%.0f\n", $8}' > angsd_peer_global_noout_allvar.round

awk '{print $0, "\t1"}' angsd_peer_global_noout_allvar.mafs > angsd_peer_global_noout_allvar.mafs.notfolded
paste angsd_peer_global_noout_allvar.mafs.notfolded angsd_peer_global_noout_allvar.round > angsd_peer_global_noout_allvar.allcount


for CHR in `cat chromosomes.txt`; do ###list of chromosomes in chromosomes.txt file 
grep "$CHR"  angsd_peer_global_noout_allvar.allcount | awk '{ print $2 "\t" $9 "\t" $7*2 "\t" $8}' > 'angsd_peer_global_noout_allvar.allcount.'$CHR
echo -e "position\tx\tn\tfolded" | cat - 'angsd_peer_global_noout_allvar.allcount.'$CHR > 'angsd_peer_global_noout_allvar.allcount.'$CHR.header
done
