#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=angsd_%j
#SBATCH --output=angsd_%j.log
#SBATCH --mem=400GB #MB
#angsd_peer_pop.sh 
#sbatch ~/scripts/angsd_peer_pop.sh deepcanyon 9
#sbatch ~/scripts/angsd_peer_pop.sh motte 4
POP=$1
NUM=$2

cd ~/wgr_peromyscus/angsd_results_peer
angsd -b $HOME/wgr_peromyscus/sample_lists/peer_goodbam_${POP}.txt -anc ~/genomes/Peer/Peer1.7.2.fasta -out $HOME/wgr_peromyscus/angsd_results_peer/angsd_peer_${POP} -P 24 -minMapQ 20 -minQ 20 -setMinDepth $NUM  -minInd $NUM -GL 1 -doMaf 1 -doMajorMinor 3 -doGlf 3 -doPost 1 -doGeno 32 -doCounts 1 -doDepth 1 -dumpCounts 1 -doSaf 1 -fold 1 -sites angsd_peer_global_noout_sites.txt
