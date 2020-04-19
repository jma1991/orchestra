#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("dynamicTreeCut")

    lib <- lapply(pkg, library, character.only = TRUE)

    mat <- readRDS(input$rds[1])

    hcl <- readRDS(input$rds[2])

    cut <- cutreeDynamic(hcl, distM = mat)

    saveRDS(cut, output$rds)

}

main(snakemake@input, snakemake@output)