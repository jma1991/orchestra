#!/usr/bin/env Rscript

main <- function(input, output, log) {
    
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    library(DropletUtils)

    sce <- readRDS(input$rds)

    set.seed(1701)

    dat <- emptyDrops(counts(sce), lower = 100, test.ambient = TRUE)

    write.csv(dat, file = output$csv, quote = FALSE, row.names = FALSE)

}

main(snakemake@input, snakemake@output, snakemake@log)