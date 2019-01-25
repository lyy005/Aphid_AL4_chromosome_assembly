# The analytical pipeline of the AL4 strain genome
This document is a walkthrough of the methods and code used to analyze the chromosome-level pea aphid genome assembly (AL4 assembly). In the aphid paper, we used HiC and Chicago library to build the chromosome-level assembly and analyzed gene family evolution on the chromosome. We also sequenced seven A. pisum individuals for detecting X chromosome, carotenoid gene and wing-dimorphism related sequence variations. 

## 1 - Genome Assembly Verification: 


### 1.1 - BUSCO analysis 
Download the AL4 assembly under the NCBI accession number: PRJNA496478

install BUSCO version 3.0.2 and Insecta near-universal single-copy orthologs from OrthoDB v9: https://busco.ezlab.org
python run_BUSCO.py -i assembly.fasta -l ./insecta_odb9/ -m geno -f -o busco_output -c 8 > assembly.log

### 1.2 - Microsatellite primer mapping
Microsatellite primer sequences can be found: TBD

makeblastdb -in assembly.fasta  -dbtype nucl

blastn -db assembly.fasta -query primers.chr1.fasta -out primers.chr1.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -db assembly.fasta -query primers.chr2.fasta -out primers.chr2.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -db assembly.fasta -query primers.chr3.fasta -out primers.chr3.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -db assembly.fasta -query primers.chrx.fasta -out primers.chrx.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"



## Quality filtering for resequencing data

## Citation:
Li Y, Park H, Smith TE, and Moran NA. 2019. Gene Family Evolution in the Pea Aphid Based on Chromosome-level Genome Assembly. 


