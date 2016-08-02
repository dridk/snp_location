import os 
from snakemake.remote.HTTP import RemoteProvider 

HTTP = RemoteProvider()

configfile: "config.json"

rule all: 
	input:
		"correlation.png",
		"ideogram.png"

rule get_hg19_size:
	input:
		hg19_size = HTTP.remote("hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes", keep_local=True, insecure=True)
	output:
		"hg19.clean.sizes"
	shell:
		"cat {input.hg19_size}|grep -we \"chr[0-9XY]*\" | awk 'BEGIN{{OFS=\"\t\"}}{{print $1,$2}}' > {output}"



rule create_binning: 
	input:
		"hg19.clean.sizes"
	output:
		"windows.bed"
	shell:
		"bedtools makewindows -g {input} -w {config[bin_size]} > {output}"




rule download_genom_size:
	input:
		HTTP.remote("hgdownload.cse.ucsc.edu/goldenpath/hg19/database/{name}.txt.gz", keep_local=True, insecure=True),
	output :
		"{name}.bed.gz"

	shell:
		"zcat {input} | cut -f2,3,4 | bgzip > {output}"



rule coverage:
	input:
		genom  = "{name}.bed.gz" ,
		window ="windows.bed"
	output:
		"{name}.coverage"
	shell:
		"bedtools coverage -a {input.window} -b {input.genom} -counts > {output}"


rule plot_correlation : 
	input :
		config["first"] + ".coverage",
		config["second"] + ".coverage",


	output: 
		"correlation.png"

	shell:
		"Rscript  --vanilla plot.r {input[0]} {input[1]} > /dev/null 2>&1"

rule plot_chromosome : 
	input :
		config["first"] + ".coverage",
		config["second"] + ".coverage",


	output: 
		"ideogram.png"

	shell:
		"Rscript  --vanilla plot_chrom.r {input[0]} {input[1]} > /dev/null 2>&1"

