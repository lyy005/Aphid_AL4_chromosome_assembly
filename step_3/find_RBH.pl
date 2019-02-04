#!/usr/bin/perl -w
use strict;
use Term::ANSIColor;
print color 'bold yellow';

die "usage: perl $0 [BLAST output] [output]\n" unless (@ARGV==2);
open IN,$ARGV[0] or die "$!\n";
open OUT,">$ARGV[1]" or die "$!\n";

my (%hash, %best);
while (my $line = <IN>) {
        chomp $line; 
	my @line = split /\s+/, $line;

	next if $line[2] eq $line[3];			# remove self best hit

	if($hash{$line[2]}){				# if there are multiple best hits  
		if($line[-1] == $best{$line[2]}){	# check if the score equals to the best hit
			push @{$hash{$line[2]}}, $line[3];	# save multiple hits into an array
		}
	}else{
		push @{$hash{$line[2]}}, $line[3];	
		$best{$line[2]} = $line[-1]; 
	}
}
close IN;

my %rbh;
foreach my $k (sort keys %hash){
	foreach my $l (sort @{$hash{$k}}){
#		next if $rbh{$l};
		if($k ~~ @{$hash{$l}} ){	# use Smart Match to find if the query is also in subject's best hits
#			$rbh{$k} = $l;
#			print OUT "$k\t$l\n";
			my @sort = ("$k", "$l");
#print "@sort\n";
			@sort = sort @sort;
#print "@sort\n";
			my $sort = join "\t", @sort;
			$rbh{$sort}= 1;
		}
	}
}

foreach my $k (sort keys %rbh){
	print OUT "$k\n";
}
close OUT;
