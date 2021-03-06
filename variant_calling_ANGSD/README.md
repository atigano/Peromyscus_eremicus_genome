## Processing of raw data and mapping to reference genome
1. ```fastp.sh``` to trim adapters and poly G tails (data sequenced with Novaseq platform).
2. ```split.sh``` to split fastq files and expedite mapping.
3. ```bwa_wgr_peer.sh``` to map trimmed whole genome resequencing data to Cactus mouse reference genome and remove duplicates
4. ```mergebams.sh``` to merge bams
5. ```sort_index``` to sort and index bams

## Variant calling in ANGSD
Note that these analyses include 25 *Peromyscus eremicus* individuals, after removal of an outlier individual based on PCA and MDS 
I run ANGSD iteratively. First I call variants with stringent quality filters across individuals from two populations (global calling) with ```angsd_peer_global_noout.sh```. All sites included in the analysis, variant and invariant, are called with ```angsd_peer_global_noout_allvar.sh```. 
High-quality variants are recalled, and allele frequencies estimated, for each of the two populations with ```angsd_peer_pop.sh```

## Estimate diversity and differentiation
I calculate the thetas with ```angsd_theta_peer_global_noout.sh``` to get estimates of π and Tajima's D across all individuals.
I use ```angsd_fst_motte_deepcanyon.sh``` to calculate FST between the two locations, Motte and Deep Canyon Reserves.

For accurate measures of π, i.e. corrected by the actual number of variant and invariant sites covered in each window see ```pi_correction_pipeline_peer_global_noout.sh```


