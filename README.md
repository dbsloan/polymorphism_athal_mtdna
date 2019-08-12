# polymorphism_athal_mtdna

Scripts used in generating data reported in the following manuscript:

Wu Z, Waneka G, Sloan DB. The tempo and mode of angiosperm mitochondrial genome divergence inferred from intraspecific variation in Arabidopsis thaliana


### repeat_pe_support.pl

The repeat_pe_support.pl script was used to generate paired-end read support for alternative genome conformations related to recombination across short repeat sequences. The script requires the [sloan.pm Perl module](https://github.com/dbsloan/perl_modules). The required command line inputs (in order are):

- A file summarizing repeat locations in the genome (see At_repeats.txt)
- A file containing mapping lines (header lines removed) from bwa-produced sam file. For efficiency, it is better if the file has been grepped to only include lines that successfully mapped to the target genome.
- The flanking distance in bp to search around each repeat for mapping (500 was used)
- The name of the target genome in the mapping file


### brassica_blast_parse.pl

The brassica_blast_parse.pl script was used to identify the allelic state in the outgroup Brassica napus for each polymorphic site in the Arabidopsis thaliana mitochondrial genome. The script requires the [sloan.pm Perl module](https://github.com/dbsloan/perl_modules) and [BioPerl](https://bioperl.org/). The required command line inputs (in order are):

- The output file from a blast search of the Arabidopsis mitogenome against the Brassica mitogenome
- A summary of Arabidopsis SNPs (see snps_for_Brassica.txt)
- A minimum length in for blast hit (400 was used)
- A minimum level of sequence identity for blast hit (0.9 was used)
