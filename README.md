# The analytical pipeline of the AL4 strain genome
This document is a walkthrough of the methods and code used to analyze the chromosome-level pea aphid genome assembly (AL4 assembly). In the aphid paper, we used HiC and Chicago library to build the chromosome-level assembly and analyzed gene family evolution on the chromosome. We also sequenced seven A. pisum individuals for detecting X chromosome, carotenoid gene and wing-dimorphism related sequence variations. 

## 1 - Genome Assembly Verification: 


### 1.1 - BUSCO analysis 
Download the AL4 assembly under the NCBI accession number: PRJNA496478

install BUSCO version 3.0.2 and Insecta near-universal single-copy orthologs from OrthoDB v9: https://busco.ezlab.org
python run_BUSCO.py -i assembly.fasta -l ./insecta_odb9/ -m geno -f -o busco_output -c 8 > assembly.log

### 1.2 - Microsatellite primer mapping
Microsatellite primer sequences can be found under: ./step_1.2/

**Extract QTL information:**

perl extract_primer_fasta.pl qtl.table primers

**Align primers to the AL4 assembly:**

makeblastdb -in assembly.fasta  -dbtype nucl

blastn -db assembly.fasta -query primers.chr1.fasta -out primers.chr1.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -db assembly.fasta -query primers.chr2.fasta -out primers.chr2.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -db assembly.fasta -query primers.chr3.fasta -out primers.chr3.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -db assembly.fasta -query primers.chrx.fasta -out primers.chrx.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

**Summarize the BLAST output**

perl check_blast.step1.pl primers.chr1.blast.out primers.chr1.fasta | grep "same" > primers.chr1.blast.out.filtered.same

perl check_blast.step1.pl primers.chr2.blast.out primers.chr2.fasta | grep "same" > primers.chr2.blast.out.filtered.same

perl check_blast.step1.pl primers.chr3.blast.out primers.chr3.fasta | grep "same" > primers.chr3.blast.out.filtered.same

perl check_blast.step1.pl primers.chr4.blast.out primers.chr4.fasta | grep "same" > primers.chr4.blast.out.filtered.same

perl check_blast.step2.pl primers.chr1.blast.out.filtered.same primers.chr1.blast.out

perl check_blast.step2.pl primers.chr2.blast.out.filtered.same primers.chr2.blast.out

perl check_blast.step2.pl primers.chr3.blast.out.filtered.same primers.chr3.blast.out

perl check_blast.step2.pl primers.chr4.blast.out.filtered.same primers.chr4.blast.out

## Quality filtering for resequencing data

## Citation:
Li Y, Park H, Smith TE, and Moran NA. 2019. Gene Family Evolution in the Pea Aphid Based on Chromosome-level Genome Assembly. 


