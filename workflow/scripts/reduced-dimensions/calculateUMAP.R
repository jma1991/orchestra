#!/usr/bin/env Rscript

main <- function(input, output, params, threads) {

    pkg <- c("BiocParallel", "uwot")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    arg <- expand.grid(n_neighbors = params$num, min_dist = params$dst)

    par <- MulticoreParam(threads)
    
    run <- bpmapply(
        FUN = umap,
        n_neighbors = arg$n_neighbors,
        min_dist = arg$min_dist,
        MoreArgs = list(X = dim, ret_model = TRUE),
        SIMPLIFY = FALSE,
        BPPARAM = par
    )
    
    num <- seq_along(run)

    for (n in num) { run[[n]]$n_neighbors <- arg$n_neighbors[n] }

    for (n in num) { run[[n]]$min_dist <- arg$min_dist[n] }

    saveRDS(run, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@threads)