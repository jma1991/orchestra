#!/usr/bin/env Rscript

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scuttle)

    library(tools)

    sce <- readRDS(input$rds[1])

    ann <- readRDS(input$rds[2])

    sub <- subset(ann, Chromosome == "MT")

    sub <- list("MT" = sub$ID)

    out <- perCellQCMetrics(sce, subsets = sub)

    rownames(out) <- colnames(sce)
    
    saveRDS(out, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log)