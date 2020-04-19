#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)
    
    fit <- DataFrame(
        low_lib_size = dat$sum < 1e5,
        low_n_features = dat$detected < 5e3,
        high_altexps_Spikes_percent = dat$altexps_Spikes_percent > 10
    )

    fit$discard <- apply(fit, 1, any)

    saveRDS(fit, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)