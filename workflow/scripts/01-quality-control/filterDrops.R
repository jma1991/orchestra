#!/usr/bin/env Rscript

main <- function(input, output, log) {

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    library(SingleCellExperiment)

    sce <- readRDS(input$rds)

    dat <- read.csv(input$csv)

    use <- which(dat$FDR < 0.05)

    sce <- sce[, use]

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)