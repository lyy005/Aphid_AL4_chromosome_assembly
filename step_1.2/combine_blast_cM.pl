#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [julie's table] [.loci file]\n" unless (@ARGV==2);

my %hash;
open IN,$ARGV[0] or die "$!\n";
<IN>;
while(<IN>){
	chomp;
	my @line = split; 
	$hash{$line[0]} = "$line[1]\t$line[2]";
}
close IN;

open IN,$ARGV[1] or die "$!\n";
while(<IN>){
	chomp;
	my $line = $_;
	my @line = split /\s+/, $line;
	print "$line\t$hash{$line[0]}\n";
}
close IN;
