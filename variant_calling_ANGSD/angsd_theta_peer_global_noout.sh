#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=angsd_%j
#SBATCH --output=angsd_%j.log
#SBATCH --mem=400GB #MB
#angsd_theta_peer_global_noout.sh 

cd ~/wgr_peromyscus/angsd_results_peer
# .saf files already produced with angsd_peer_global_noout.sh
#a. Obtain the maximum likelihood estimate of the SFS using the realSFS program
realSFS angsd_peer_global_noout.saf.idx -P 24 > angsd_peer_global_noout_folded.sfs

#b. Calculate the thetas for each site
cd ~/wgr_peromyscus/angsd_results_peer
angsd -b ~/wgr_peromyscus/sample_lists/peer_goodbam_all_noout.txt -anc ~/genomes/Peer/Peer1.7.2.fasta -out ~/wgr_peromyscus/angsd_results_peer/angsd_peer_global_noout_folded.sfs -P 24 -doThetas 1 -doSaf 1 -pest angsd_peer_global_noout_folded.sfs -GL 1 -fold 1 -sites angsd_peer_global_noout_sites.txt


#c. Estimate Tajimas D and other statistics (chromosome estimates)
thetaStat do_stat angsd_peer_global_noout_folded.sfs.thetas.idx
