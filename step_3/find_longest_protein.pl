#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [pep.fasta] [output]\n" unless (@ARGV==2);
open IN,$ARGV[0] or die "$!\n";
open OUT,">$ARGV[1]" or die "$!\n";

# input format: 
# >AL4000559-RB
# >AL4000559-RA

my (%len, %pick);
$/=">";
<IN>;
while(<IN>) {
	chomp;
	my $line = $_;
	my @line = split/\n+/, $line;

	my $name = shift @line;
	my @name = split /\s+/, $name;
	my @gene_id = split /\-/, $name[0];

	my $seq = join "", @line;
	my $len = length ($seq);

	if(defined $len{$gene_id[0]}){
		if($len > $len{$gene_id[0]}){
			$len{$gene_id[0]} = $len;
			$pick{$gene_id[0]} =  $name;
#print "$gene_id[0]\t$len\n";
		}
	}else{
		$len{$gene_id[0]} = $len;
		$pick{$gene_id[0]} = $name;
	}	
}	
close IN;

my @picks = values %pick;
open IN,$ARGV[0] or die "$!\n";
$/=">";
while(<IN>) {
	chomp;
	my $line = $_;
	my @line = split/\n+/, $line;
	
	my $name = shift @line;
	my $seq = join "", @line;

#	if($name ~~ [values %pick]){
	if($name ~~ @picks){
		print OUT ">$name\n$seq\n";
	}
}
close IN;

print "Done\n";
