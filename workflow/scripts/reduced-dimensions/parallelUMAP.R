#!/usr/bin/env Rscript

main <- function(input, output, params, log, threads) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(BiocParallel)

    library(bluster)

    library(uwot)

    dim <- readRDS(input$rds)

    mem <- clusterRows(dim, NNGraphParam())

    arg <- expand.grid(n_neighbors = params$n_neighbors, min_dist = params$min_dist)

    par <- MulticoreParam(threads, RNGseed = 1701)

    run <- bpmapply(
        FUN = umap,
        n_neighbors = arg$n_neighbors,
        min_dist = arg$min_dist,
        MoreArgs = list(X = dim, pca = NULL),
        SIMPLIFY = FALSE,
        BPPARAM = par
    )

    attr(run, "cluster") <- mem
    
    idx <- seq_along(run)

    for (i in idx) { rownames(run[[i]]) <- rownames(dim) }

    for (i in idx) { colnames(run[[i]]) <- c("UMAP.1", "UMAP.2") }

    for (i in idx) { attr(run[[i]], "n_neighbors") <- arg$n_neighbors[i] }

    for (i in idx) { attr(run[[i]], "min_dist") <- arg$min_dist[i] }

    saveRDS(run, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log, snakemake@threads)