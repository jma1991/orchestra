#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scater)

    sce <- readRDS(input$rds)

    out <- perCellQCMetrics(sce)
    
    write.csv(out, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@log)