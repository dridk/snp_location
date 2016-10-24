# snp_location
Compare snp location between two human genom. This pipeline create bins across the whole genom and count how many SNP they are.

## Requirement 
* Snakemake
* bedtools
* R : biocLite
* R : IdeoViz

## Launch 

Just type :

    snakemake 

Downloaded data are not required. Snakemake will download all requirements.00   
You can edit config file or pass value directly to the command line. First and second are the name of personal human genom comming from UCSC.

    snakemake --config bin_size=100000 first=pgVenter second=pgWatson

To compute from the scratch, add -F : 

    snakemake -F --config bin_size=100000 first=pgVenter second=pgWatson

## Results 

 ![ideogram](https://github.com/dridk/snp_location/raw/master/results/ideogram.png  "Ideogram")
 ![correlation](https://github.com/dridk/snp_location/raw/master/results/correlation.png "Correlation")


