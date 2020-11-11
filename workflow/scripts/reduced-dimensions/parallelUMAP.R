#!/usr/bin/env Rscript

main <- function(input, output, log, threads) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(BiocParallel)

    library(uwot)

    dim <- readRDS(input$rds)

    arg <- expand.grid(
        n_neighbors = c(3, 5, 15, 30, 50, 100), 
        min_dist = c(0, 0.01, 0.05, 0.1, 0.5, 1)
    )

    par <- MulticoreParam(threads, RNGseed = 42)

    run <- bpmapply(
        FUN = umap,
        n_neighbors = arg$n_neighbors,
        min_dist = arg$min_dist,
        MoreArgs = list(X = dim),
        SIMPLIFY = FALSE,
        BPPARAM = par
    )
    
    idx <- seq_along(run)

    for (i in idx) { rownames(run[[i]]) <- rownames(dim) }

    for (i in idx) { colnames(run[[i]]) <- c("UMAP1", "UMAP2") }

    for (i in idx) { attr(run[[i]], "n_neighbors") <- arg$n_neighbors[i] }

    for (i in idx) { attr(run[[i]], "min_dist") <- arg$min_dist[i] }

    saveRDS(run, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@threads)