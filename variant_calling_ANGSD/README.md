# Processing of raw data and mapping to reference genome
1. ```fastp.sh``` to trim adapters and poly G tails (data sequenced with Novaseq platform).
2. ```split.sh``` to split fastq files and expedite mapping.
3. ```bwa_wgr_peer.sh``` to map trimmed whole genome resequencing data to Cactus mouse reference genome and remove duplicates
4. ```mergebams.sh``` to merge bams
5. ```sort_index``` to sort and index bams

# Variant calling in ANGSD
## These analyses are absed on 25 *Peromyscus eremicus* individuals, after removal of an outlier individual
### I run ANGSD iteratively
