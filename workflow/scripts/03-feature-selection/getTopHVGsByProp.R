#!/usr/bin/env Rscript

var.field <- function(x) {

    # Identify metric of variation

    x <- "bio" %in% colnames(x)

    x <- ifelse(x, "bio", "ratio")

}

main <- function(input, output, params) {

    library(scran)

    dec <- read.csv(input$csv, row.names = 1)

    var <- var.field(dec)

    hvg <- getTopHVGs(dec, var.field = var, prop = params$pro)

    writeLines(hvg, con = output$txt)

}

main(snakemake@input, snakemake@output, snakemake@params)
