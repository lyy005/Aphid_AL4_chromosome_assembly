#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [qtl.table] [output prefix]\n" unless (@ARGV==2);

my %hash;
open IN,$ARGV[0] or die "$!\n";
<IN>;
while(<IN>){
	chomp;
	my @line = split; 
	$hash{$line[2]} .= ">$line[0]_F\n$line[-2]\n>$line[0]_R\n$line[-1]\n";

}
close IN;

foreach my $k (sort keys %hash){
	open OT, ">$ARGV[1]\.$k\.fasta" or die "$!\n";

	print OT "$hash{$k}";

	close OT;
}
