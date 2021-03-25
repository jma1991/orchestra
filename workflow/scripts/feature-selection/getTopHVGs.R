#!/usr/bin/env Rscript

var.field <- function(x) {

    # Identify the relevant metric of variation

    x <- "bio" %in% colnames(x)

    ifelse(x, "bio", "ratio")

}

var.threshold <- function(x) {

    # Identify the minimum threshold on the metric of variation

    d <- c("bio" = 0, "ratio" = 1)

    v <- var.field(x)

    d[v]

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    dec <- readRDS(input$rds)

    set.seed(1701)

    hvg <- getTopHVGs(
        stats = dec, 
        n = params$n,
        prop = params$prop,
        var.field = var.field(dec), 
        var.threshold = var.threshold(dec), 
        fdr.threshold = params$fdr_threshold
    )

    saveRDS(hvg, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)
