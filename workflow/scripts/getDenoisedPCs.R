#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds[1])

    dec <- readRDS(input$rds[2])

    dim <- getDenoisedPCs(sce, technical = dec)

    num <- ncol(dim$components)

    saveRDS(num, output$rds)

}

main(snakemake@input, snakemake@output)