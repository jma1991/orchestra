#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("ggplot2", "scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    dim <- reducedDim(sce, "UMAP")

    dat <- as.data.frame(dim)

    ggsave(output$pdf, plot = plt, width = 4, height = 3)

}

main(snakemake@input, snakemake@output)