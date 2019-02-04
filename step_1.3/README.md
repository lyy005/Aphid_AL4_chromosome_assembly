# Alignment using bowtie2 and samtools
bowtie2-build assembly.fasta assembly

bowtie2 -x assembly -U ./AL4f_Trimmomatic.fastq.gz -S AL4f.sam
bowtie2 -x assembly -U ./AUSf_Trimmomatic.fastq.gz -S AUSf.sam
bowtie2 -x assembly -U ./AL4m-B_Trimmomatic.fastq.gz -S AL4m-B.sam
bowtie2 -x assembly -U ./AL4mw-B_Trimmomatic.fastq.gz -S AL4mw-B.sam
bowtie2 -x assembly -U ./AL4m-C_Trimmomatic.fastq.gz -S AL4m-C.sam
bowtie2 -x assembly -U ./AL4mw-C_Trimmomatic.fastq.gz -S AL4mw-C.sam
bowtie2 -x assembly -U ./LSR1cf_Trimmomatic.fastq.gz -S LSR1cf.sam

samtools view -h -b -S AL4f.sam -o AL4f.bam
samtools view -h -b -S AL4mw-B.sam -o AL4mw-B.bam
samtools view -h -b -S AUSf.sam -o AUSf.bam
samtools view -h -b -S LSR1cf.sam -o LSR1cf.bam
samtools view -h -b -S AL4m-B.sam -o AL4m-B.bam
samtools view -h -b -S AL4mw-C.sam -o AL4mw-C.bam
samtools view -h -b -S AL4m-C.sam -o AL4m-C.bam

samtools sort AL4f.bam AL4f_sorted
samtools sort AL4m-B.bam AL4m-B_sorted
samtools sort AL4m-C.bam AL4m-C_sorted
samtools sort AL4mw-B.bam AL4mw-B_sorted
samtools sort AL4mw-C.bam AL4mw-C_sorted
samtools sort AUSf.bam AUSf_sorted
samtools sort LSR1cf.bam LSR1cf_sorted

samtools index AL4f_sorted.bam
samtools index AL4m-C_sorted.bam
samtools index AL4mw-C_sorted.bam
samtools index LSR1cf_sorted.bam
samtools index AL4m-B_sorted.bam
samtools index AL4mw-B_sorted.bam
samtools index AUSf_sorted.bam

# calculate sequencing depth using bedtools and mosdepth
bedtools makewindows -g ../../dovetail_genomeFile.txt -w 10000 -s 2000 > dovetail.windows.bed

mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 AL4m-B AL4m-B_sorted.bam 
mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 AL4m-C AL4m-C_sorted.bam 
mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 AL4mw-B AL4mw-B_sorted.bam 
mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 AL4mw-C AL4mw-C_sorted.bam 
mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 AL4f AL4f_sorted.bam 
mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 LSR1cf LSR1cf_sorted.bam 
mosdepth -b dovetail.windows.bed -f dovetail.fasta -n -t 20 AUSf AUSf_sorted.bam 

# normalize based on male and female separately
gunzip -dc LSR1cf.regions.bed.gz | sort -k1,1 -k2,2n > LSR1cf.regions.bed.sort
gunzip -dc AL4f.regions.bed.gz | sort -k1,1 -k2,2n > AL4f.regions.bed.sort
gunzip -dc AUSf.regions.bed.gz | sort -k1,1 -k2,2n > AUSf.regions.bed.sort
gunzip -dc AL4m-B.regions.bed.gz | sort -k1,1 -k2,2n > AL4m-B.regions.bed.sort
gunzip -dc AL4m-C.regions.bed.gz | sort -k1,1 -k2,2n > AL4m-C.regions.bed.sort
gunzip -dc AL4mw-B.regions.bed.gz | sort -k1,1 -k2,2n > AL4mw-B.regions.bed.sort
gunzip -dc AL4mw-C.regions.bed.gz | sort -k1,1 -k2,2n > AL4mw-C.regions.bed.sort

paste AL4m-B.regions.bed.sort AL4m-C.regions.bed.sort AL4mw-B.regions.bed.sort AL4mw-C.regions.bed.sort AUSf.regions.bed.sort LSR1cf.regions.bed.sort AL4f.regions.bed.sort > all.combined.table

awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$8"\t"$12"\t"$16"\t"$20"\t"$24"\t"$28}' all.combined.table > all.combined.table.reordered

# Males are normalized based on wingless A males (depth = 28.44); Females are normalized by LSR1 female (depth = 38.46)
perl scale_by_median_forMalesAndFemales.pl all.combined.table.reordered all.combined.table.reordered.scaled

# SNP calling
freebaye-parallel <(/freebayes/scripts/fasta_generate_regions.py assembly.fasta.fai 100000) 72 -f assembly.fasta -b AL4f_sorted.bam /stor/work/Ochman/yli19/raw_data/20190919_aphidReseqHiSeq2500/JA18299-87128041/AL4m_C-156298163/AL4m-C_sorted.bam /stor/work/Ochman/yli19/raw_data/20190919_aphidReseqHiSeq2500/JA18299-87128041/AL4mw_C-156288155/AL4mw-C_sorted.bam /stor/work/Ochman/yli19/raw_data/20190919_aphidReseqHiSeq2500/JA18299-87128041/AL4m_B-156302163/AL4m-B_sorted.bam /stor/work/Ochman/yli19/raw_data/20190919_aphidReseqHiSeq2500/JA18299-87128041/AL4mw_B-156296155/AL4mw-B_sorted.bam /stor/work/Ochman/yli19/raw_data/20190919_aphidReseqHiSeq2500/JA18299-87128041/AUSf-156299165/AUSf_sorted.bam /stor/work/Ochman/yli19/raw_data/20190919_aphidReseqHiSeq2500/JA18299-87128041/LSR1cf-156300171/LSR1cf_sorted.bam -Q 20 > freebayes.vcf

# VCF file filtering, ref: http://ddocent.com/filtering/
vcffilter -f "QUAL > 20" freebayes.vcf > freebayes_qual20.vcf
vcffilter -s -f "AB > 0.25 & AB < 0.75 | AB < 0.01" freebayes_qual20.vcf > freebayes_qual20-AB.vcf # filter by allelic balance
vcffilter -f "MQM / MQMR > 0.95 & MQM / MQMR < 1.05" freebayes_qual20-AB.vcf > freebayes_qual20-AB-MQM.vcf # filter by the ratio of mapping qualities between reference and alternate alleles
vcffilter -f "QUAL / DP > 0.25" freebayes_qual20-AB-MQM.vcf > freebayes_qual20-AB-MQM-DP.vcf 
vcfallelicprimitives freebayes_qual20-AB-MQM-DP.vcf --keep-info --keep-geno > freebayes_qual20-AB-MQM-DP-prim.vcf

vcftools --vcf freebayes_qual20-AB-MQM-DP-prim.vcf --recode-INFO-all --out freebayes_qual20-AB-MQM-DP-prim-removehighdepth.vcf  --max-meanDP 59.95 --recode
mv freebayes_qual20-AB-MQM-DP-prim-removehighdepth.vcf.recode.vcf freebayes_qual20-AB-MQM-DP-prim-removehighdepth.vcf
vcftools --vcf freebayes_qual20-AB-MQM-DP-prim-removehighdepth.vcf  --remove-indels --recode --recode-INFO-all --out freebayes_qual20-AB-MQM-DP-prim-removehighdepth-SNP.vcf

/stor/work/Ochman/hyunjin/data/genomes/dovetail/python_scripts/vcf_table.py


# keep SNPs in gene region:
less -S freebayes_parallel_attempt4_qual20-AB-MQM-DP-prim-removehighdepth-SNP-tab.vcf | perl -e 'while(<>){s/(Scaffold_\d+)\;HRSCAF\=\d+/$1/g; print;}' > rename.vcf

# redo heterozygosity analysis
awk '$2 == "maker"{print}' all.gff > all.maker.gff 
#awk '$3 == "gene"{print}' all.maker.gff > all.maker.gene.gff

bedtools intersect -a rename.vcf -b all.maker.gff -header > gene_region.maker.vcf
#bedtools intersect -a rename.vcf -b all.maker.gene.gff -header > gene_region.maker.gene.vcf

less -S gene_region.maker.vcf | perl -e 'while(<>){if($hash{$_}){}else{$hash{$_} = 1; print;}}' > gene_region.maker.unique.vcf
#less -S gene_region.maker.gene.vcf | perl -e 'while(<>){if($hash{$_}){}else{$hash{$_} = 1; print;}}' > gene_region.maker.gene.unique.vcf

perl heterozygosity.pl gene_region.maker.unique.vcf # print out heterozygous sites
# heterozygous sites: 80684	145055	80361	106713	80339	80763	115502
# total length
less -S all.maker.gene.gff| perl -e 'while(<>){@a=split; $len=$a[4]-$a[3]; $tot+=$len;}print "$tot\n";'
# total sites: 169730247

