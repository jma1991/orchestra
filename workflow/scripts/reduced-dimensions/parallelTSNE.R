#!/usr/bin/env Rscript

main <- function(input, output, log, threads) {
    
    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(BiocParallel)

    library(Rtsne)

    dim <- readRDS(input$rds)

    arg <- expand.grid(
        perplexity = c(3, 5, 15, 30, 50, 100), 
        max_iter = c(500, 1000, 1500, 2000, 2500, 3000)
    )

    par <- MulticoreParam(threads, RNGseed = 42)

    run <- bpmapply(
        FUN = Rtsne,
        perplexity = arg$perplexity,
        max_iter = arg$max_iter,
        MoreArgs = list(X = dim),
        SIMPLIFY = FALSE,
        BPPARAM = par
    )

    idx <- seq_along(run)

    for (i in idx) { run[[i]] <- run[[i]]$Y }

    for (i in idx) { rownames(run[[i]]) <- rownames(dim) }

    for (i in idx) { colnames(run[[i]]) <- c("TSNE1", "TSNE2") }

    for (i in idx) { attr(run[[i]], "perplexity") <- arg$perplexity[i] }

    for (i in idx) { attr(run[[i]], "max_iter") <- arg$max_iter[i] }

    saveRDS(run, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@threads)