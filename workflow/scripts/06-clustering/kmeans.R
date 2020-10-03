#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    set.seed(1701)
    
    fit <- kmeans(dim, centers = wildcards$num)

    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)