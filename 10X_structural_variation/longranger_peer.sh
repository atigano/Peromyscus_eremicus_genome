#!/bin/bash
#SBATCH --partition=shared,macmanes
#SBATCH --export=ALL
#SBATCH --ntasks=1 --cpus-per-task=24
#SBATCH --signal=2
#SBATCH --no-requeue
#SBATCH --job-name=long
#SBATCH --output=long_%j.log
#SBATCH -e long_%j.err
#SBATCH --mem=450GB #MB
#SBATCH --exclude node117,node118
###longranger_peer.sh

module load linuxbrew/colsa
longranger wgs --id=PEER_freebayes --reference=~/genomes/Peer/refdata-Peer1.7.2 --fastqs=~/genomes/Peer/10x/rawdata/ --vcmode=freebayes --localcores=24
