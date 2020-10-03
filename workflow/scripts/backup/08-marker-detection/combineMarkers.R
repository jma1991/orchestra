#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    res <- readRDS(input$rds)

    sig <- combineMarkers(res$statistics, res$pairs, pval.type = wildcards$val)

    saveRDS(sig, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)