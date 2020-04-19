#!/usr/bin/env Rscript

main <- function(input, output, wildcards) {

    pkg <- c("igraph", "scran")

    lib <- lapply(pkg, library, character.only = TRUE)

    snn <- readRDS(input$rds)

    arg <- list(
        "louvain" = "cluster_louvain",
        "walktrap" = "cluster_walktrap"
    )

    fun <- arg[[wildcards$fun]]

    com <- do.call(fun, list(snn))

    fct <- factor(com$membership)

    saveRDS(fct, output$rds)

}

main(snakemake@input, snakemake@output, snakemake@wildcards)