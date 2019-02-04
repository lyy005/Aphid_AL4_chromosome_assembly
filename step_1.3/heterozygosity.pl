#!/usr/bin/perl -w
use strict;

my @count;
die "usage: perl $0 [vcf file (gene_region.vcf) ]\n" unless (@ARGV==1);
open IN,$ARGV[0] or die "$!\n";
while(<IN>){
	chomp;
	my $line=$_;

	if($line =~ /^#/){

	}else{
		my @line = split/\s+/, $line; 
		my @geno = @line[9..15]; 

		my $c = 0;

		foreach my $k (@geno){
			my @k = split /\:/, $k;
			if(($k[0] =~ /0/)&&($k[0] =~ /1/)){
#print "### $k[0]\n";
				$count[$c] ++;
			}
			$c ++;
		}
	}
}
close IN;

my $count = join "\t", @count;
print "# heterozygous sites: $count\n";
