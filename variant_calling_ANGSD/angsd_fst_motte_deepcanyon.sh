#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=fst
#SBATCH --output=fst_%j.log
#SBATCH --mem=400GB #MB

###angsd_pairwise_fst.sh
#sbatch ~/scripts/angsd_fst_motte_deepcanyon.sh
cd ~/wgr_peromyscus/angsd_results_peer

# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS angsd_peer_motte.saf.idx angsd_peer_deepcanyon.saf.idx > peer_motte_deepcanyon.2dSFS

# Estimating Fst in angsd
realSFS fst index angsd_peer_motte.saf.idx angsd_peer_deepcanyon.saf.idx -sfs peer_motte_deepcanyon.2dSFS -fstout peer_motte_deepcanyon.alpha_beta

realSFS fst print peer_motte_deepcanyon.alpha_beta.fst.idx > peer_motte_deepcanyon.alpha_beta.txt

awk '{ print $0 "\t" $3 / $4 }' peer_motte_deepcanyon.alpha_beta.txt > peer_motte_deepcanyon.fst
sort -k 1,1n -k 2,2n peer_motte_deepcanyon.fst

realSFS fst stats2 peer_motte_deepcanyon.alpha_beta.fst.idx -win 50000 -step 50000 -type 2 > peer_motte_deepcanyon.alpha_beta.fst_50kb
#(head -n 1 peer_motte_deepcanyon.alpha_beta.fst_50kb && tail -n +2 peer_motte_deepcanyon.alpha_beta.fst_50kb | sort -k 2,2n -k 3,3n ) > peer_motte_deepcanyon.alpha_beta.fst_50kb_sorted
(head -n 1 peer_motte_deepcanyon.alpha_beta.fst_50kb && tail -n +2 peer_motte_deepcanyon.alpha_beta.fst_50kb | sort -k 2,2V -k 3,3n ) > peer_motte_deepcanyon.alpha_beta.fst_50kb_vsorted
