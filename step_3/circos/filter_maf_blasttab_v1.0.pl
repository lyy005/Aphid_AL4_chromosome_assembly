#!/usr/bin/perl -w
use strict;

my %hash;

die "usage: perl $0 [ self.maf.masked.blasttab ] [ self.maf.masked.blasttab.noself ]\n # for circos plot, alignment length >= 5000 bp\n # add the function that check reversed alignment from the same sequences\n" unless (@ARGV==2);
open IN,$ARGV[0] or die "$!\n";
open OUT,">$ARGV[1]" or die "$!\n";
while (my $line=<IN>) {
        my @line=split(/\s+/,$line);

	if(($line[0] eq $line[1])&&($line[6] == $line[8])&&($line[7] == $line[9])){
#		next;
#print "### $line\n";
	}elsif($line[3] >= 5000){
#	}elsif($line[3] >= 10000){
#	}else{
		my @sort1 = ($line[6], $line[7]);
		@sort1 = sort {$a <=> $b} @sort1; 
		my $query = $line[0]."_".$sort1[0]."_".$sort1[1];

		my @sort2 = ($line[8], $line[9]);
		@sort2 = sort {$a <=> $b} @sort2;
		my $sub = $line[1]."_".$sort2[0]."_".$sort2[1];
		my @sort = ($query, $sub);
		@sort = sort @sort;
		my $sort = join ";", @sort;
		if(defined $hash{$sort}){
		}else{
			$hash{$sort} = $line;
			print OUT "$line";
		}
	}
}
close IN;

#foreach my $k (sort keys %hash){
#	print OUT "$hash{$k}";
#}
close OUT;
