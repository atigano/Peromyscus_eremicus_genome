#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --job-name=piwin
#SBATCH --output=piwin_%j.log
#SBATCH --mem=400GB #MB
####pi_correction_pipeline_peer_global_noout.sh
#sbatch ~/scripts/pi_correction_pipeline_peer_global_noout.sh 50
#sbatch ~/scripts/pi_correction_pipeline_peer_global_noout.sh 1

WIN=$1 ###win size in kb

module load linuxbrew/colsa
###out of the loop
###make windows
bedtools makewindows -g ~/genomes/Peer/Peer1.7.2.fasta.fai -w ${WIN}000 | awk '$3 ~ /000$/' | sed 's/ /\t/g'> genome_windows_${WIN}k.bed

###make bed file from the theta file containing pi
tail -n +2 angsd_peer_global_noout_folded.sfs.thetas.site > angsd_peer_global_noout_folded.sfs.thetas.site_nohead
cut -f2 angsd_peer_global_noout_folded.sfs.thetas.site_nohead | awk '{$1 = $1 + 1; print}' | paste angsd_peer_global_noout_folded.sfs.thetas.site_nohead - | awk 'BEGIN {FS="\t"};{ print $1"\t"$2"\t"$8"\t"$4}' | sed 's/ //g' > pi_peer_global_noout.bed

###in the loop
for CHR in `cat chromosomes.txt`; do ###list of chromosomes in chromosomes.txt file; do
###make bed file for all variant and invariant sites for each chromosome
grep "$CHR" angsd_peer_global_noout_allvar.mafs > angsd_peer_global_noout_allvar_${CHR}.mafs
cut -f 1,2 angsd_peer_global_noout_allvar_${CHR}.mafs > peer_global_noout_allvar.sites_${CHR}.txt
cut -f2 peer_global_noout_allvar.sites_${CHR}.txt | awk '{$1 = $1 + 1; print}' | paste peer_global_noout_allvar.sites_${CHR}.txt - | sed 's/ //g'> peer_global_noout_allvar.sites_${CHR}.bed

###split the genome window file in chr
grep "$CHR" genome_windows_${WIN}k.bed > genome_windows_${WIN}k_${CHR}.bed

###calculate the number of sites in each window for each chromosome
bedtools coverage -a genome_windows_${WIN}k_${CHR}.bed -b peer_global_noout_allvar.sites_${CHR}.bed -counts > allsites_${WIN}kbwin_${CHR}.txt
cut -f4 allsites_${WIN}kbwin_${CHR}.txt | sed 's/\t0/NA/g' > allsites_${WIN}kwin_NA_${CHR}.txt

###split the per site theta file
grep "$CHR" pi_peer_global_noout.bed > pi_peer_global_noout_${CHR}.bed

awk '{print exp($4)}' pi_peer_global_noout_${CHR}.bed | paste pi_peer_global_noout_${CHR}.bed - > pi_peer_global_noout_log_${CHR}.bed

bedtools map -a genome_windows_${WIN}k_${CHR}.bed -b pi_peer_global_noout_log_${CHR}.bed -c 5 -o sum | sed 's/\t[.]/\tNA/g' - > pi_peer_global_noout_log_${WIN}kbwin_${CHR}.txt
###pi_peer_global_noout_log_50kbwin_chr2_pilon.txt 

paste pi_peer_global_noout_log_${WIN}kbwin_${CHR}.txt allsites_${WIN}kwin_NA_${CHR}.txt | sed 's/[.]\t/NA\t/g' - > pi_peer_global_noout_log_${WIN}kbwin_sites_${CHR}.txt

awk '{if(/NA/)var="NA";else var=$4/$5;print var}' pi_peer_global_noout_log_${WIN}kbwin_sites_${CHR}.txt | paste pi_peer_global_noout_log_${WIN}kbwin_sites_${CHR}.txt - > pi_peer_global_noout_log_${WIN}kbwin_sites_corrected_${CHR}.txt

done
