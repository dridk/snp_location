require(IdeoViz)
require(RColorBrewer)
args = commandArgs(trailingOnly=TRUE)

fileA = args[1]
fileB = args[2]

# fileA = "pgWatson.coverage"
# fileB = "pgVenter.coverage"

A = read.table(fileA, as.is = T, sep="\t", header=F)
B = read.table(fileB, as.is = T, sep="\t", header=F)
ideo <- getIdeo("hg19")


data = GRanges(A$V1, IRanges(start = A$V2, end = A$V3) )
mcols(data)$value = scale(B$V4- A$V4)

png("ideogram.png", width = 2000, height = 800)
par(mar = c(0, 0, 0, 0), mfrow = c(1,1))
plotOnIdeo(chrom = seqlevels(data),
           ideoTable = ideo,
           values_GR = data,
           value_cols = colnames(mcols(data)),
           col = 'orange',
           addScale = F,
           val_range=c(-5,5),
           plotType='rect',
           plot_title = paste("Differrence between", gsub(".coverage","",fileA), gsub(".coverage","",fileB)),
           cex.axis = 0.5,
           chromName_cex = 0.6,
           vertical = T
        )

dev.off()

