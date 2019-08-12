#!/usr/bin/perl

use strict;
use warnings;
use sloan;
use Bio::SearchIO; 

my $usage = "\nUSAGE: $0 blastOutputFile variant_file min_length min_ID\n\n";

my $blastFile = shift or die ($usage);
my $variant_file = shift or die ($usage);
my $min_len = shift or die ($usage);
my $min_ID = shift or die ($usage);


my %blast_HoH;

my $SearchIO_obj = new Bio::SearchIO(-format => 'blast', -file   => $blastFile);


while( my $result_obj = $SearchIO_obj->next_result ) {
  while ( my $hit_obj = $result_obj->next_hit ) {
   	while (my $hsp_obj = $hit_obj->next_hsp){
   		if ($hsp_obj->length('query') >= $min_len && $hsp_obj->frac_identical >= $min_ID){
   			my $pos = $hsp_obj->start('query');
   			my $query_string = $hsp_obj->query_string;
   			my $hit_string = $hsp_obj->hit_string;
   			length ($query_string) == length ($hit_string) or die ("\nERROR: query and hit string lengths do not match.\n\n");
   			for (my $i = 0; $i < length ($query_string); ++$i){
   				unless (substr ($query_string, $i, 1) eq '-'){
   					$blast_HoH{$pos}->{uc (substr ($hit_string, $i, 1))} = 1;
   					++$pos;
   				}
   			} 
   		}
   	}
  }
}

my @snp_lines = file_to_array ($variant_file);

my $header = shift (@snp_lines);
chomp $header;
print "$header\tBrassica napus\n";

foreach (@snp_lines){
	chomp $_;
	my @sl = split (/\t/, $_);
	if (exists ($blast_HoH{$sl[0]})){
		my @keys = sort keys %{$blast_HoH{$sl[0]}};
		my $first_key = shift @keys;
		print "$_\t$first_key";
		foreach my $key (@keys){
			print ";$key";
		}
		print "\n";
	}else{
		print "$_\tNA\n";
	}
}