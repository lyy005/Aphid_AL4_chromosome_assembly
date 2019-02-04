# LAST alignment
lastdb -P0 -uNEAR -R01 dovetail dovetail.rename.masked.fasta 
nohup lastal -P0 -m50 -E0.05 -C2 dovetail dovetail.rename.masked.fasta >  self.maf & 
last-postmask self.maf > self.maf.masked

# to blast tab
maf-convert -n blasttab self.maf.masked > self.maf.masked.blasttab
perl filter_maf_blasttab_v1.0.pl self.maf.masked.blasttab self.maf.masked.blasttab.noself

# calculate other scaffolds
perl calculate_coverage.pl  self.maf.masked.blasttab.noself > self.maf.masked.blasttab.noself.long_4
sort -k 1,1 self.maf.masked.blasttab.noself.long_4 > self.maf.masked.blasttab.noself.long_4.sorted
bedtools genomecov -i self.maf.masked.blasttab.noself.long_4.sorted -g dovetail_long4.genome -bg > dovetail_long4.coverage

# circos plot
perl ./circos-0.69-6/bin/circos -conf circos_paralogs.conf
