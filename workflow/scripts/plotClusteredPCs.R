#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    fit <- readRDS(input$rds)

    num <- metadata(fit)$chosen

    pdf(output$pdf)

    plot(fit$n.pcs, fit$n.clusters, xlab = "Number of PCs", ylab = "Number of clusters")

    abline(a = 1, b = 1, col = "red")

    abline(v = num, col = "grey", lty = 2)

    dev.off()

}

main(snakemake@input, snakemake@output)