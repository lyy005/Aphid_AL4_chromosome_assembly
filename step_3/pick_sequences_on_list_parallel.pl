#!/usr/bin/perl -w
use strict;

die "perl $0 [fasta] [name list] [output directory] [type (pep / rna)]\n" unless @ARGV == 4;

my %hash;
open (LS, "$ARGV[1]") or die "$ARGV[0] $!\n";
while(<LS>){
	chomp;
	s/\>//;
	my @line = split /\s+/;
	$hash{$line[0]} = 1;
	$hash{$line[1]} = 1;
}
close LS;

my %seq;
open (IN, "$ARGV[0]") or die "$ARGV[0] $!\n";
$/=">";
<IN>;
while(<IN>){
	chomp;
	my $all = $_;
	my @line = split /\n+/;
	my $id = shift @line;
	my $seq = join "", @line;
	my @id = split /\s+/, $id;

	if($hash{$id[0]}){
		$seq{$id[0]} = $seq; 
	}
}
close IN;

my $c = 0;
$/="\n";
open (LS, "$ARGV[1]") or die "$ARGV[0] $!\n";
while(<LS>){
	chomp;
	my @line = split /\s+/;

	$c ++;
	open (OUT, ">$ARGV[2]/$c\.$ARGV[3].fasta") or die "$ARGV[2] $!\n";
	print OUT ">$line[0]\n$seq{$line[0]}\n>$line[1]\n$seq{$line[1]}\n";
	close OUT;
}
print "$c pairs in total\n";
