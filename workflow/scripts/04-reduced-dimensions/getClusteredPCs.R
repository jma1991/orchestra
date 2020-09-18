#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    dim <- read.csv(input$csv, row.names = 1)

    fit <- getClusteredPCs(dim)

    fit <- fit[, c("n.pcs", "n.clusters")]

    write.csv(fit, file = output$csv)

    num <- metadata(fit)$chosen

    chr <- as.character(num)
    
    writeLines(chr, con = output$txt)

}

main(snakemake@input, snakemake@output, snakemake@log)