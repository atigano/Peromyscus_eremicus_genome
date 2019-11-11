#SBATCH --partition=macmanes,shared
#SBATCH -J bwa
#SBATCH --cpus-per-task=6
#SBATCH --output bwa.%A_%a.log
#SBATCH --array=0-60%16
#SBATCH --exclude node117
sbatch ~/scripts/bwa_wgr_peer.sh wgr_peer_individuals.sh
module load linuxbrew/colsa

cd ~/wgr_peromyscus/rawdata

SAMPLELIST=$1
for SAMPLE in `cat $SAMPLELIST`; do


echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID

ARRAY_NUM=`printf %02d $SLURM_ARRAY_TASK_ID`

bwa mem -t 6 ~/genomes/Peer/Peer1.7.2.fasta \
${SAMPLE}_R1_0"$ARRAY_NUM".fastq \
${SAMPLE}_R2_0"$ARRAY_NUM".fastq \
| samblaster --removeDups | samtools view -S -h -b -@6 -o ${SAMPLE}_"$ARRAY_NUM".bam
done

### To delete small empty files
find . -name "*.bam" -size -160c -delete
