# protein coding genes: BLAST proteins to genomes
makeblastdb -in assembly.fasta  -dbtype nucl
tblastn -db assembly.fasta -query caro.pep.fasta -out caro.blast.out -evalue 1e-10 -outfmt 6

tblastn -db assembly.fasta -query AmiD.fasta -out AmiD.fasta.blast -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
tblastn -db assembly.fasta -query BCR_ShigenobuStern2013.fasta -out BCR_ShigenobuStern2013.fasta.blast -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" 
tblastn -db assembly.fasta -query LdcA1.fasta -out LdcA1.fasta.blast -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" 
tblastn -db assembly.fasta -query RlpA.fasta -out RlpA.fasta.blast -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" 
tblastn -db assembly.fasta -query SP.fasta -out SP.fasta.blast -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

# api gene
perl split_scaffolds_by_Ns.v1.0.pl api.fasta api.Ns.fasta
blastn -db assembly.fasta -query api.Ns.fasta -out api.Ns.fasta.blast.out -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
