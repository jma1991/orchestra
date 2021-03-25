#!/usr/bin/env Rscript

set.seed(1701)

modelMatrix <- function(x, data) {

    nan <- is.null(x)

    if (nan) return(NULL)

    mod <- model.matrix(x, data = data)

}

main <- function(input, output, params, log, threads) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    sce <- readRDS(input$rds)

    dec <- modelGeneVar(sce)

    dec <- DataFrame(id = rowData(sce)$ID, symbol = rowData(sce)$Symbol, dec, row.names = rownames(sce))

    saveRDS(dec, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log, snakemake@threads)
