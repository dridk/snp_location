# snp_location
Compare snp location between two personal human genom. This pipeline create binning of [bin_size]pb across the whole genom. For each bin, it counts how many snp stay there for [first] and [second] human genom.   
It computes the correlation plot and an ideogram.  

## Requirement 
* Snakemake
* R : biocLite
* R : IdeoViz

## Configuration 
Edit first config.json. first and second value are the name of personal genom comming from uscc. Check http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/. 

## Launch 

Just type :

    snakemake 

No data a required. It will download everything.   
You can specify argument without editing config.json 

    snakemake --config bin_size=100000 first=pgVenter second=pgWatson

To recompute from the scratch, add -F : 

    snakemake -F --config bin_size=100000 first=pgVenter second=pgWatson

## Results 

 ![ideogram](https://github.com/dridk/snp_location/raw/master/results/ideogram.png  "Ideogram")
 ![correlation](https://github.com/dridk/snp_location/raw/master/results/correlation.png "Correlation")


