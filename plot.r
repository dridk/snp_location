require(IdeoViz)
require(RColorBrewer)
args = commandArgs(trailingOnly=TRUE)

fileA = args[1]
fileB = args[2]

# fileA = "pgWatson.coverage"
# fileB = "pgVenter.coverage"

print(fileA)
print(fileB)

A = read.table(fileA, as.is = T, sep="\t", header=F)
B = read.table(fileB, as.is = T, sep="\t", header=F)



windows_size = A$V3[1] - A$V2[1]
par(mar = c(0, 0, 0, 0), mfrow = c(1,1))
png(filename = "correlation.png", width = 800, height= 600, units = "px")
plot(A$V4, B$V4, xlab = fileA, ylab = fileB, main = paste0("Correlation of SNP count in windows binning = ", windows_size))

dev.off()
