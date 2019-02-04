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

	if(defined $hash{$name}){
		if($hash{$name} eq $line[2]){
			my @name = split /\_/, $name;
			my $dir = pop @name;
			my $primer_id = join "_", @name;
#print "$primer_id\t$loci\n";
			$loci{$primer_id}{$dir} = $loci unless $loci{$name}{$dir};
#print "$loci{$primer_id}{$dir}\n";
		}
	}
}
close IN2; 

my $F = "F";
my $R = "F";
foreach my $k (sort keys %loci){
#print "###$loci{$k}{$F}";
	if($loci{$k}{"F"}){
		if($loci{$k}{"F"} > $loci{$k}{"R"}){
			print "$k\t$loci{$k}{'R'}\n";
		}else{
			print "$k\t$loci{$k}{'F'}\n";
		}
	}
}
