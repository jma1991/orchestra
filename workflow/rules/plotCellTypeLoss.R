#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("edgeR")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    ave <- list(
        lost = counts(sce)[, !lgl]),
        kept = counts(sce)[, lgl])
    )

    ##

    mat <- cbind(ave$lost, ave$kept)

    cpm <- cpm(mat, log = TRUE, prior.count = 1)
    
    lfc <- cpm[, 1] - cpm[, 2]

    ave <- rowMeans(cpm)

    ##

    out <- isOutlier(lfc, type = "both")


    pdf(output$pdf)
    
    plot(ave, lfc, xlab = "Average count", ylab = "Fold change (Filter/Select)", pch = 16)
    
    points(ave[out], lfc[out], col = "dodgerblue", pch = 16)

    dev.off()

}

main(snakemake@input, snakemake@output)