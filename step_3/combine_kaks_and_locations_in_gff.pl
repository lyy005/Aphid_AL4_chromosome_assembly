#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [reciprecal table] [gff file] [kaks table] [output]\n" unless (@ARGV==4);
open IN1,$ARGV[0] or die "$!\n";
open IN2,$ARGV[1] or die "$!\n";
open IN3,$ARGV[2] or die "$!\n";
open OUT,">$ARGV[3]" or die "$!\n";

my (%start, %end, %scaf);
while(<IN2>) {
	my $line = $_;
	next if ($line =~ /^#/);

	chomp;
	my @line = split/\s+/, $line;
	if($line[2] eq "mRNA"){

		if($line[-1] =~ /ID=([^\;]+)\;/){
#print "###$1\n";
			$scaf{$1} = $line[0];
			$start{$1} = $line[3];
			$end{$1} = $line[4];
		}else{
			print "Gff file mRNA name formwat error $line[-1];\n";
		}
	}
}
close IN2;

my (%ka, %ks);
while(my $line = <IN3>){
	my @line = split/\s+/, $line;
	$ka{$line[0]} = $line[2];
	$ks{$line[0]} = $line[3];
}
close IN3;

while (my $line = <IN1>) {
        chomp $line; 
	my @line = split /\s+/, $line;

	my $distance;
	if($scaf{$line[0]} ne $scaf{$line[1]}){
		$distance = "-10000000";
	}elsif(($start{$line[0]} == $start{$line[1]})||($end{$line[0]} == $end{$line[1]})){	# different mRNAs from the same gene
		$distance = 0;	
	}elsif($end{$line[0]} < $start{$line[1]}){
		$distance = $start{$line[1]} - $end{$line[0]};
	}elsif($end{$line[1]} < $start{$line[0]}){
		$distance = $start{$line[0]} - $end{$line[1]};
	}else{
		$distance = 0;
		print "Location error: $line: $start{$line[0]}:$end{$line[0]}\t$start{$line[1]}:$end{$line[1]}\n";
	}

	my $kaks_key = $line[0]."-".$line[1];
	my ($ka, $ks);
	if(defined $ka{$kaks_key}){
		$ka = $ka{$kaks_key};
		$ks = $ks{$kaks_key};
	}else{
		print "KaKs value not found: $line[0] $line[1]\n";
		$ka = 0;
		$ks = 0;
	}

	print OUT "$line\t$scaf{$line[0]}\t$start{$line[0]}\t$end{$line[0]}\t$scaf{$line[1]}\t$start{$line[1]}\t$end{$line[1]}\t$distance\t$ka\t$ks\n";
}	
close IN1;
print "Done\n";
