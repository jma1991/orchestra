#!/usr/bin/env Rscript

main <- function(input, output, params) {

    pkg <- c("scater")

    lib <- lapply(pkg, library, character.only = TRUE)

    dat <- readRDS(input$rds)
    
    out <- DataFrame(
        low_lib_size = dat$sum < 1e5,
        low_n_features = dat$detected < 5e3,
        high_subsets_MT_percent = dat$subsets_MT_percent > 10
        high_altexps_ERCC_percent = dat$altexps_ERCC_percent > 10
    )


    if (params$sub) {

        num <- length(params$sub)

        itr <- seq_len(num)

        for (i in itr) {

            



        }

    }


    sub <- paste("subsets", params$sub, "percent", sep = "_")
    
    alt <- paste("altexps", params$alt, "percent", sep = "_")





    out$discard <- apply(out, 1, any)

    saveRDS(out, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params)