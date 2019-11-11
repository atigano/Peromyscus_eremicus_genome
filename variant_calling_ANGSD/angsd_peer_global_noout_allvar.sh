#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=angsd_%j
#SBATCH --output=angsd_%j.log
#SBATCH --mem=400GB #MB
#angsd_peer_global_noout_allvar.sh global calling

#cd ~/genomes/Peer
#samtools faidx Peer1.7.2.fasta
cd ~/wgr_peromyscus/angsd_results_peer
angsd -b $HOME/wgr_peromyscus/sample_lists/peer_goodbam_all_noout.txt -anc ~/genomes/Peer/Peer1.7.2.fasta -out $HOME/wgr_peromyscus/angsd_results_peer/angsd_peer_global_noout_allvar -P 24 -minMapQ 20 -minQ 20 -setMinDepth 13 -minInd 13 -GL 1 -doMaf 1 -doMajorMinor 1 -doPost 1 -doCounts 1 -doDepth 1
