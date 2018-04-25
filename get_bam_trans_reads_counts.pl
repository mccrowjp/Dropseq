#!/usr/bin/env perl
use strict;

my $infile = shift;

unless($infile) {
    die "Usage: $0 [BAM file (with XC and GE tags)]\n";
}

my %xccount;
my %xcgecount;
my %xcnotmapped;
my $count_noxc = 0;

open(IN, "samtools view $infile 2>/dev/null |");
print STDERR "reading $infile\n";

while(<IN>) {
    chomp;
    my ($id, $flag, $rname, $pos, $mapq, $cigar, $rnext, $pnext, $tlen, $seq, $qual, @cols) = split(/\t/);

    my $xc = "";
    my $ge = "";
    foreach my $v (@cols) {
	if($v =~ /^XC:Z:(\S+)/) {
	    $xc = $1;
	} elsif($v =~ /^GE:Z:(\S+)/) {
	    $ge = $1;
	}
    }
    if($xc) {
	if($ge) {
	    $xcgecount{$xc}{$ge}++;
	    $xccount{$xc}++;
	} else {
	    $xcnotmapped{$xc}++;
	}
    } else {
	$count_noxc++;
    }
}
close(IN);

print join("\t", ('barcode', 'reads', 'genes', 'unmapped_reads'))."\n";
foreach my $xc (sort {$xccount{$b}<=>$xccount{$a}} keys %xccount) {
    print join("\t", ($xc, $xccount{$xc}, scalar(keys %{$xcgecount{$xc}}), $xcnotmapped{$xc}))."\n";
}

if($count_noxc > 0) {
    print STDERR "Reads with no XC tag: $count_noxc\n";
}
