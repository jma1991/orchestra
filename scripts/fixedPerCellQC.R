#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)

    out <- DataFrame(
        low_lib_size = dat$sum < 1e5,
        low_n_features = dat$detected < 5e3
    )

    out$discard <- apply(out, 1, any)

    saveRDS(out, output$rds)

}

main(snakemake@input, snakemake@output)