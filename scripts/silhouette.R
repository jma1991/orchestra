#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("dynamicTreeCut")

    lib <- lapply(pkg, library, character.only = TRUE)

    mat <- readRDS(input$rds[1])

    hcl <- readRDS(input$rds[2])

    sil <- silhouette(hcl, dist = mat)

    pdf(output$pdf)

    plot(sil)

    dev.off()

}

main(snakemake@input, snakemake@output)