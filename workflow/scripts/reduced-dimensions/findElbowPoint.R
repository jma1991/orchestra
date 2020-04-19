#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("PCAtools")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    var <- attr(dim, "percentVar")
    
    num <- findElbowPoint(var)

    saveRDS(num, output$rds)

}

main(snakemake@input, snakemake@output)