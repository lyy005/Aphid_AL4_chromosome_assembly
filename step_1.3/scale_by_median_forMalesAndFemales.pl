#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [multicov bed file] [output]\n" unless (@ARGV == 2);

open IN,$ARGV[0] or die "$!\n";
open OUT,">$ARGV[1]" or die "$!\n";

my $count = 0;
my (@b, @c, @bw, @cw, @aus, @lsr1, @al4, @loc, @blank);
while (<IN>) {
	chomp;
	my $line = $_;
	my @line = split /\s+/, $line;
#	my $name = $line[0];

#	push @loc, $line[1];
	push @b, $line[3];
	push @c, $line[4];
	push @bw, $line[5];
	push @cw, $line[6];
	push @aus, $line[7];
	push @lsr1, $line[8];
	push @al4, $line[9];

#print "###$line[1]\n";
	$count ++;

#print "###$line[1]\n";
}
close IN;
#my $loc_median = median(@loc);
my $b_median = median(@b);
my $c_median = median(@c);
my $bw_median = median(@bw);
my $cw_median = median(@cw);
my $aus_median = median(@aus);
my $lsr1_median = median(@lsr1);
my $al4_median = median(@al4);

print "Median coverage: $b_median\t$c_median\t$bw_median\t$cw_median\t$aus_median\t$lsr1_median\t$al4_median\n";

# scale the bed file
open IN,$ARGV[0] or die "$!\n";
while (<IN>) {
	chomp;
	my $line = $_;
	my @line = split /\s+/, $line;
	
# male scale based on the first male sample (wingless B)
	$line[3] = sprintf("%.2f", $line[3]);
	$line[4] = sprintf("%.2f", ($line[4] / $c_median) * $b_median);
	$line[5] = sprintf("%.2f", ($line[5] / $bw_median) * $b_median);
	$line[6] = sprintf("%.2f", ($line[6] / $cw_median) * $b_median);

# female scale based on the second female sample (LSR1cf)
	$line[7] = sprintf("%.2f", ($line[7] / $aus_median) * $lsr1_median);
	$line[8] = sprintf("%.2f", $line[8]);
	$line[9] = sprintf("%.2f", ($line[9] / $al4_median) * $lsr1_median);

	$line = join "\t", @line;

	print OUT "$line\n";
}	

sub median{
	my @vals = sort {$a <=> $b} @_;
	my $len = @vals;
	if($len%2){ #odd?
		return $vals[int($len/2)];
	}else{ #even
		return ($vals[int($len/2)-1] + $vals[int($len/2)])/2;
	}
}
