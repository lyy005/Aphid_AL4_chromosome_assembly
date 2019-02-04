# The analytical pipeline of the AL4 strain genome
This document is a walkthrough of the methods and code used to analyze the chromosome-level pea aphid genome assembly (AL4 assembly). In the aphid paper, we used HiC and Chicago library to build the chromosome-level assembly and analyzed gene family evolution on the chromosome. We also sequenced seven A. pisum individuals for detecting X chromosome, carotenoid gene and wing-dimorphism related sequence variations. 

## 1 - Genome Assembly Verification: 


### 1.1 - BUSCO analysis 
Download the AL4 assembly under the NCBI accession number: PRJNA496478

install BUSCO version 3.0.2 and Insecta near-universal single-copy orthologs from OrthoDB v9: https://busco.ezlab.org
python run_BUSCO.py -i assembly.fasta -l ./insecta_odb9/ -m geno -f -o busco_output -c 8 > assembly.log

### 1.2 - Microsatellite primer mapping
Microsatellite primer sequences can be found under: ./step_1.2/

Scripts can be found: ./step_1.2/cmd.sh

### 1.3 - Sequencing depth evaluation and Heterozygosity calculation: 
Data and scripts can be found: ./step_1.3/

## 2 - Genome Annotation: 

## 3 - Genome Duplication Analysis: 

## 4 - Location of Functional Genes: 

## Quality filtering for resequencing data

## Citation:
Li Y, Park H, Smith TE, and Moran NA. 2019. Gene Family Evolution in the Pea Aphid Based on Chromosome-level Genome Assembly. 


