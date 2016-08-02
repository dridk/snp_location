require(IdeoViz)
require(RColorBrewer)
args = commandArgs(trailingOnly=TRUE)

fileA = args[1]
fileB = args[2]

# fileA = "pgWatson.coverage"
# fileB = "pgVenter.coverage"

A = read.table(fileA, as.is = T, sep="\t", header=F)
B = read.table(fileB, as.is = T, sep="\t", header=F)

windows_size = A$V3[1] - A$V2[1]

ideo <- getIdeo("hg19")


data = GRanges(A$V1, IRanges(start = A$V2, end = A$V3) )
mcols(data)$value = scale(B$V4- A$V4)

png("ideogram.png", width = 4000, height = 1200,  units = "px")
par(mar = c(0, 0, 0, 0), mfrow = c(1,1))
plotOnIdeo(chrom = seqlevels(data),
           ideoTable = ideo,
           values_GR = data,
           value_cols = colnames(mcols(data)),
           col = 'orange',
           addScale = F,
           val_range=c(-5,5),
           plotType='rect',
           plot_title = paste("Differrence between", gsub(".coverage","",fileA), gsub(".coverage","",fileB), "bin",windows_size),
           cex.axis = 0.8,
           chromName_cex = 0.6,
           vertical = T
        )

dev.off()

