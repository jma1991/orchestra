#!/usr/bin/env Rscript

main <- function(input, output, params, threads) {

    pkg <- c("BiocParallel", "Rtsne")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    arg <- expand.grid(perplexity = params$per, max_iter = params$itr)

    par <- MulticoreParam(threads, RNGseed = 1701)

    run <- bpmapply(
        FUN = Rtsne,
        perplexity = arg$perplexity,
        max_iter = arg$max_iter,
        MoreArgs = list(X = dim),
        SIMPLIFY = FALSE,
        BPPARAM = par
    )

    idx <- seq_along(run)

    for (i in idx) { run[[i]] <- run[[i]]$Y } # extract TSNE matrix

    for (i in idx) { attr(run[[i]], "perplexity") <- arg$perplexity[i] }

    for (i in idx) { attr(run[[i]], "max_iter") <- arg$max_iter[i] }

    saveRDS(run, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@threads)