#!/usr/bin/perl -w
use strict;

die "usage: perl $0 [input file] [output]\n" unless (@ARGV==2);

open IN,$ARGV[0] or die "$!\n";
open OUT,">$ARGV[1]" or die "$!\n";

my $seq;

$/=">";
<IN>;
while (<IN>) {
	chomp;
	my $line = $_;
	my @line = split /\n+/, $line;

	my $name = shift @line;

print "### $name";

	my @name = split/\s+/, $name;

	$seq = join "", @line;
	my @seq = split /N+/, $seq;

	my $c = 0;
	foreach my $k (@seq){
		$c ++;

		my @pos = match_positions($k,$seq);
		my $pos = join "_", @pos;
		print OUT ">$name[0]\_split_$c\_$pos\n$k\n";
	}
}

sub match_positions {
    my ($regex, $string) = @_;
    return if not $string =~ /$regex/;
    return ($-[0]+1, $+[0]);
}

