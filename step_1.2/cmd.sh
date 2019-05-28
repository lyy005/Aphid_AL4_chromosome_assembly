#Extract QTL information:
perl extract_primer_fasta.pl qtl.table primers

#Align primers to the AL4 assembly:
makeblastdb -in assembly.fasta -dbtype nucl
blastn -db assembly.fasta -query primers.chr1.fasta -out primers.chr1.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
blastn -db assembly.fasta -query primers.chr2.fasta -out primers.chr2.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
blastn -db assembly.fasta -query primers.chr3.fasta -out primers.chr3.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
blastn -db assembly.fasta -query primers.chrx.fasta -out primers.chrx.blast.out -evalue 1 -task blastn-short -outfmt "6 qlen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

#Summarize the BLAST output
perl check_blast.step1.v3.pl primers.chr1.blast.out primers.chr1.fasta | grep "same"|perl -e 'while(<>){@a=split; if($a[-1]=~/\,/){}else{print}}' > primers.chr1.blast.out.filtered.same
perl check_blast.step1.v3.pl primers.chr2.blast.out primers.chr2.fasta | grep "same"|perl -e 'while(<>){@a=split; if($a[-1]=~/\,/){}else{print}}' > primers.chr2.blast.out.filtered.same
perl check_blast.step1.v3.pl primers.chr3.blast.out primers.chr3.fasta | grep "same"|perl -e 'while(<>){@a=split; if($a[-1]=~/\,/){}else{print}}' > primers.chr3.blast.out.filtered.same
perl check_blast.step1.v3.pl primers.chr4.blast.out primers.chr4.fasta | grep "same"|perl -e 'while(<>){@a=split; if($a[-1]=~/\,/){}else{print}}' > primers.chr4.blast.out.filtered.same

perl check_blast.step2.v2.pl primers.chr1.blast.out.filtered.same primers.chr1.blast.out > primers.chr1.blast.out.filtered.same.loci
perl check_blast.step2.v2.pl primers.chr2.blast.out.filtered.same primers.chr2.blast.out > primers.chr2.blast.out.filtered.same.loci
perl check_blast.step2.v2.pl primers.chr3.blast.out.filtered.same primers.chr3.blast.out > primers.chr3.blast.out.filtered.same.loci
perl check_blast.step2.v2.pl primers.chr4.blast.out.filtered.same primers.chr4.blast.out > primers.chr4.blast.out.filtered.same.loci

perl combine_blast_cM.v2.pl qtl.table primers primers.chr1.blast.out.filtered.same.loci > primers.chr1.blast.out.filtered.same.loci.combined
perl combine_blast_cM.v2.pl qtl.table primers primers.chr2.blast.out.filtered.same.loci > primers.chr2.blast.out.filtered.same.loci.combined
perl combine_blast_cM.v2.pl qtl.table primers primers.chr3.blast.out.filtered.same.loci > primers.chr3.blast.out.filtered.same.loci.combined
perl combine_blast_cM.v2.pl qtl.table primers primers.chr4.blast.out.filtered.same.loci > primers.chr4.blast.out.filtered.same.loci.combined

