#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    dec <- lapply(input$rds, readRDS)

    ids <- Reduce(intersect, lapply(sce, rownames))
    
    dec <- lapply(dec, "[", i = ids, )

    dec <- do.call(combineVar, dec)

    saveRDS(dec, file = output$rds)

}

main(snakemake@input, snakemake@output)