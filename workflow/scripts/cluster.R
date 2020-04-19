#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("igraph")

    lib <- lapply(pkg, library, character.only = TRUE)

    snn <- readRDS(input$rds)

    com <- cluster_walktrap(snn)

    mem <- com$membership

    saveRDS(mem, output$rds)

}

main(snakemake@input, snakemake@output)