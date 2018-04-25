#!/usr/bin/env Rscript
args <- commandArgs(TRUE)
intable = paste("", args[1], sep="")
outpdf = paste("", args[2], sep="")

if(intable == 'NA' || outpdf == 'NA') {
    message("Usage: plot_trans_reads_counts.r [input table] [output pdf]")
    
} else {

    dat = read.delim(intable, header=T)
    dat[is.na(dat[,4]),4]=0

    x.reads = cumsum(dat[,2])
    x.reads = x.reads/max(x.reads)
    x.genes = cumsum(dat[,3])
    x.genes = x.genes/max(x.genes)
    x.unmap = cumsum(dat[,4])
    x.unmap = x.unmap/max(x.unmap)
    x.tot = cumsum(dat[,2] + dat[,4])
    x.tot = x.tot/max(x.tot)

    pdf(outpdf)
    plot(1:length(x.reads), x.reads, type='l', col="blue", xlab="cell barcodes", ylab="cumulative fraction", ylim=c(0,1))
    lines(1:length(x.genes), x.genes, type='l', col="green")
    lines(1:length(x.unmap), x.unmap, type='l', col="gray")
    lines(1:length(x.tot), x.tot, type='l', col="black")
    legend("bottomright", inset=0.01, lty=1, cex=0.8, col=c("blue","green","gray","black"), legend=c("genic_reads","genes","intergenic_reads","total_reads"))

    plot(1:length(x.reads), x.reads, type='l', col="blue", xlab="cell barcodes", ylab="cumulative fraction", xlim=c(1,50000), ylim=c(0,1))
    lines(1:length(x.genes), x.genes, type='l', col="green")
    lines(1:length(x.unmap), x.unmap, type='l', col="gray")
    lines(1:length(x.tot), x.tot, type='l', col="black")
    legend("topleft", inset=0.01, lty=1, cex=0.8, col=c("blue","green","gray","black"), legend=c("genic_reads","genes","intergenic_reads","total_reads"))

    plot(1:length(x.reads), x.reads, type='l', col="blue", xlab="cell barcodes", ylab="cumulative fraction", xlim=c(1,5000), ylim=c(0,1))
    lines(1:length(x.genes), x.genes, type='l', col="green")
    lines(1:length(x.unmap), x.unmap, type='l', col="gray")
    lines(1:length(x.tot), x.tot, type='l', col="black")
    legend("topleft", inset=0.01, lty=1, cex=0.8, col=c("blue","green","gray","black"), legend=c("genic_reads","genes","intergenic_reads","total_reads"))

    plot(1:length(x.reads), x.reads, type='l', col="blue", xlab="cell barcodes", ylab="cumulative fraction", xlim=c(1,500), ylim=c(0,1))
    lines(1:length(x.genes), x.genes, type='l', col="green")
    lines(1:length(x.unmap), x.unmap, type='l', col="gray")
    lines(1:length(x.tot), x.tot, type='l', col="black")
    legend("topleft", inset=0.01, lty=1, cex=0.8, col=c("blue","green","gray","black"), legend=c("genic_reads","genes","intergenic_reads","total_reads"))
    dev.off()
}
