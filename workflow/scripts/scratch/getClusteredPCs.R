#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    fit <- getClusteredPCs(dim, min.rank = 1)
    
    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output)