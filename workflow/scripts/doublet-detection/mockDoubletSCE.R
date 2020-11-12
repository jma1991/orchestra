#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scater)

    sce <- readRDS(input$rds[1])

    dbl <- readRDS(input$rds[2])

    lgl <- isOutlier(dbl$num.de, type = "lower", log = TRUE)

    ids <- rownames(dbl)[lgl]

    sce$Doublet <- sce$Cluster %in% ids

    sce$Density <- readRDS(input$rds[3])

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)