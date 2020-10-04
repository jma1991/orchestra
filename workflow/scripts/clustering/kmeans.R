#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scran)

    dim <- readRDS(input$rds)

    set.seed(42)
    
    fit <- kmeans(dim, centers = params$centers)

    out <- factor(fit$cluster)

    saveRDS(out, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)