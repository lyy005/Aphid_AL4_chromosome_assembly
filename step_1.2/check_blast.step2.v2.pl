#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [filtered output] [blast.out file]\n" unless (@ARGV==2);

my %hash;
my %loci;
open IN,$ARGV[0] or die "$!\n"; 
while(<IN>){
	chomp;
	my $line = $_;
	my @line = split/\s+/, $line;
	
	$hash{$line[0]} = $line[1];
	$hash{$line[0]."_F"} = $line[1];
	$hash{$line[0]."_R"} = $line[1];
}
close IN;


open IN2,$ARGV[1] or die "$!\n";
while(<IN2>){
	chomp;
	my $line = $_;
	my @line = split /\s+/, $line;
	my $name = $line[1];

	my $loci = $line[-4];
	$loci = $line[-3] if $line[-3] < $loci;

	my @name = split /\_/, $name;
	my $dir = pop @name;			 # direction ID: F or R
	my $primer_id = join "_", @name; 	 # primer ID: T_126605_1_Y

#print "$name\n";
	if(defined $hash{$name}){
		if($hash{$name} eq $line[2]){
			push @{$loci{$primer_id}{$dir}}, $loci;  # if multiple hits are found on the same scaffold, keep all
		}
	}
}
close IN2; 

foreach my $k (sort keys %loci){
	my $min = 1000000000000;
	my $minF;
	my $minR;
	
	foreach my $x (@{$loci{$k}{"F"}}){
		foreach my $y (@{$loci{$k}{"R"}}){
			my $dist = abs($x - $y);

			if($dist < $min){
				$min = $dist;

				if ($y > $x){ 
					$minF = $x;
					$minR = $y;
				}else{
					$minF = $y;
					$minR = $x;
				}
			}
		}
	}
	#print "$k\t$minF\t$minR\n";
	print "$k\t$minF\n";
}
