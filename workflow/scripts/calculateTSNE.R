#!/usr/bin/env Rscript

main <- function(input, output, params, threads) {

    pkg <- c("BiocParallel", "Rtsne")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    arg <- expand.grid(perplexity = params$per, max_iter = params$itr)

    par <- MulticoreParam(threads)

    run <- bpmapply(
        FUN = Rtsne,
        perplexity = arg$perplexity,
        max_iter = arg$max_iter,
        MoreArgs = list(X = dim),
        SIMPLIFY = FALSE,
        BPPARAM = par
    )

    num <- seq_along(run)

    for (n in num) { run[[n]]$perplexity <- arg$perplexity[n] }

    for (n in num) { run[[n]]$max_iter <- arg$max_iter[n] }

    saveRDS(run, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@threads)