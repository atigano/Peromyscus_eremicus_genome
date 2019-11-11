#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=angsd_%j
#SBATCH --output=angsd_%j.log
#SBATCH --mem=400GB #MB
#angsd_peer_global_noout.sh global calling

cd ~/genomes/Peer
samtools faidx Peer1.7.2.fasta
cd ~/wgr_peromyscus/angsd_results_peer
angsd -b $HOME/wgr_peromyscus/sample_lists/peer_goodbam_all_noout.txt -anc ~/genomes/Peer/Peer1.7.2.fasta -out $HOME/wgr_peromyscus/angsd_results_peer/angsd_peer_global_noout -P 24 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -setMinDepth 13 -minInd 13 -minMaf 0.01 -GL 1 -doMaf 1 -doMajorMinor 1 -doGlf 3 -doPost 1 -doGeno 32 -doCounts 1 -doDepth 1 -dumpCounts 1 -doSaf 1 -fold 1

###To create and index SNP list file
gunzip -c angsd_peer_global_noout | cut -f1-4 - | tail -n +2 > angsd_peer_global_noout_sites.txt
angsd sites index angsd_peer_global_noout_sites.txt
