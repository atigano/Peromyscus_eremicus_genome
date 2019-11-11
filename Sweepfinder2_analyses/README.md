To identify selective sweeps I used Sweepfinder2. I use allele frequencies as outputted by ANGSD,
First, I converted allele frequencies into allele counts and formatted the file for Sweepfinder2 with the script ```sweepfinder_prep.sh``` separately for each chromosome.

I then combined all individual chromosome files to calculate the Site Frequency Sprectrum in Sweepfinder2
```cat angsd_peer_global_noout_allvar.allcount.chr[!X]_*pilon > angsd_peer_global_noout_allvar.allcount.combined_nox
echo -e "position\tx\tn\tfolded" | cat - angsd_peer_global_noout_allvar.allcount.combined_nox > angsd_peer_global_noout_allvar.allcount.combined.header_nox
SweepFinder2 -f angsd_peer_global_noout_allvar.allcount.combined.header_nox angsd_peer_global_noout_allvar.allcount.spectrum_nox```

Sweepfinder2 was run of each chromosome separately with the following command (exmple for chr1
```SweepFinder2 -lg 10000 angsd_peer_global_noout_allvar.allcount.chr1_pilon.header angsd_peer_global_noout_allvar.allcount.spectrum_nox sweepfinder_results/sweep_noout_allvar.chr1_pilon_nox_10k```

