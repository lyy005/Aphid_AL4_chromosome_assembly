#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [blast.out file] [qtl fasta file]\n" unless (@ARGV==2);

my %hash;
open FA,$ARGV[1] or die "$!\n";
while(<FA>){
	chomp;
	if(/>/){
		my $line = $_;
		$line =~s/\>//;
		my @line = split /\_/, $line;
		my $dir = pop @line;
		my $pri = join "_", @line;
		$hash{$pri}{$dir} = "NA";
	}
}

open IN,$ARGV[0] or die "$!\n"; 
while(<IN>){
	chomp;
	my $line = $_;
	my @line = split/\s+/, $line;
	
	my $name = $line[1];
#print "###$line[1]\n";
	my @name = split /\_/, $name;

	my $dir = pop @name;
	my $pri = join "_", @name;
	

	if(($line[4] == $line[0])&&($line[3] == 100)){
		if($hash{$pri}{$dir} eq "NA"){
			$hash{$pri}{$dir} = $line[2];
		}else{
			if($hash{$pri}{$dir} =~ $line[2]){
			}else{
				$hash{$pri}{$dir}.= ",".$line[2];
			}
		}
	}
}
close IN;

foreach my $k (sort keys %hash){
	print "$k\t";

	if($hash{$k}{"F"}){
		print "$hash{$k}{'F'}\t";
	}else{
		$hash{$k}{'F'} = "NA";
		print "NA!!!\t";
	}

	if($hash{$k}{"R"}){
		print "$hash{$k}{'R'}\t";
	}else{
		$hash{$k}{'R'} = "NA";
		print "NA!!!\t";
	}

	my @forward = split /\,/, $hash{$k}{'F'};
	my @reverse = split /\,/, $hash{$k}{'R'};

	my %in_array2 = map { $_ => 1 } @forward;
	my @share = grep { $in_array2{$_} } @reverse;
	

	if(@share > 0){
		my $share = join ",", @share;
		print "\tsame: $share\n";
	}else{
		print "\tdifferent\n"
	}
}
