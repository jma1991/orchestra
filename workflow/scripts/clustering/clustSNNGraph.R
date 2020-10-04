#!/usr/bin/env Rscript

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(igraph)

    snn <- readRDS(input$rds)

    arg <- list(
        "louvain" = "cluster_louvain",
        "walktrap" = "cluster_walktrap"
    )

    fun <- arg[[params$fun]]

    com <- do.call(fun, list(snn))

    fct <- factor(com$membership)

    saveRDS(fct, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)