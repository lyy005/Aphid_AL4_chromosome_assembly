#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [ self.maf.masked.blasttab.noself ]\n # for circos plot, alignment length >= 5000 bp\n # add the function that check reversed alignment from the same sequences\n" unless (@ARGV==1);
open IN,$ARGV[0] or die "$!\n";

my %hash = (
	'Scaffold_20849' => '1', 
	'Scaffold_21967' => '1',
	'Scaffold_21646' => '1',
	'Scaffold_21773' => '1',
);

while (my $line=<IN>) {
        my @line=split(/\s+/,$line);

	my $count = 0;
	if($line[0] ne $line[1]){
		$count ++ if $hash{$line[0]}; 
		$count ++ if $hash{$line[1]};
	}

#	print "$line" 
	if ($count == 1){
		my @sort;
		if($hash{$line[0]}){
			@sort = ($line[6], $line[7]);
			@sort = sort {$a <=> $b} @sort; 
			print "$line[0]\t$sort[0]\t$sort[1]\n";
		}elsif($hash{$line[1]}){
			@sort = ($line[8], $line[9]);
			@sort = sort {$a <=> $b} @sort;
			print "$line[1]\t$sort[0]\t$sort[1]\n";
		}
	}
}
close IN;
