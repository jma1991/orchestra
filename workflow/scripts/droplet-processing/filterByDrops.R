#!/usr/bin/env Rscript

replace.ambient <- function(x) {

    # Replace results for barcodes with totals less than or equal to lower

    i <- x$Total <= metadata(x)$lower

    x$LogProb[i] <- NA

    x$PValue[i] <- NA

    x$Limited[i] <- NA

    x$FDR[i] <- NA

    p <- x$PValue
    
    i <- x$Total >= metadata(x)$retain

    p[i] <- 0

    x$FDR <- p.adjust(p, method = "BH")

    return(x)

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")


    # Script function

    library(SingleCellExperiment)

    sce <- readRDS(input$rds[1])

    res <- readRDS(input$rds[2])

    res <- replace.ambient(res)

    use <- which(res$FDR < params$FDR)

    sce <- sce[, use]

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)