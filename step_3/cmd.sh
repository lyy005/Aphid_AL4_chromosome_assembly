# get CDS info from the annotation result from step 2
perl gff2fasta.pl all.gff dovetail.rename.fasta > all.cds.fasta

# rename the sequences in the fasta file
less -S all.cds.fasta| perl -e 'while(<>){if(/>([^\:]+)\:/){print ">$1\n";}else{print}}' > all.cds.rename.fasta 

# translate cds sequences to amino acid sequences
perl cds2aa.pl all.cds.rename.fasta NUC all.aa.fasta > cds2aa.log 

# find the longest isoform for each gene
perl find_longest_protein.pl all.proteins.fasta all.proteins.fasta.longest

# make blast db
makeblastdb -in all.proteins.fasta.longest -dbtype prot

# run all to all blastp
nohup blastp -db all.proteins.fasta.longest -query all.proteins.fasta.longest -out all.proteins.fasta.longest.blast.allout -evalue 1e-10 -outfmt "6 qlen slen qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" -num_threads 4 &

# filter BLAST results with at least 30% similar and 150 aa in length
awk '(($5 >=30)&&($6 >= 150)){print}' all.proteins.fasta.longest.blast.allout > all.proteins.fasta.longest.blast.allout.filtered

# find reciprocal best hits
perl find_RBH.pl all.proteins.fasta.longest.blast.allout.filtered all.proteins.fasta.longest.blast.allout.filtered.table

# extract DNA for dNdS analysis / this script also makes a new folder (./parallel_all_pep/) to run KaKs calculate in parallel
perl pick_sequences_on_list_parallel.pl all.cds.rename.fasta all.proteins.fasta.longest.blast.allout.filtered.table ./parallel_all_pep/ cds

cd ./parallel_all_pep/
ls *.fasta > fasta.list
sh batch.aln.sh

cat *.cds.fasta.kaks | grep -v "^Sequence" > kaks.table
perl combine_kaks_and_locations_in_gff.pl all.proteins.fasta.longest.blast.allout.filtered.table all.gff ./parallel_all_pep/kaks.table all.proteins.fasta.longest.blast.allout.filtered.table.distanceKaKs

