#!/usr/bin/env Rscript

var.field <- function(x) {

    # Identify the relevant metric of variation

    x <- "bio" %in% colnames(x)

    x <- ifelse(x, "bio", "ratio")

}

var.threshold <- function(x) {

    # Identify the minimum threshold on the metric of variation

    d <- list("bio" = 0, "ratio" = 1)

    v <- var.field(x)

    x <- d[[v]]

}

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    dec <- readRDS(input$rds)
    
    hvg <- getTopHVGs(
        stats = dec, 
        var.field = var.field(dec), 
        var.threshold = var.threshold(dec), 
        fdr.field = "FDR", 
        fdr.threshold = 0.05
    )

    saveRDS(hvg, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)
