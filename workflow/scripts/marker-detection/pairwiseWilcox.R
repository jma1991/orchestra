#!/usr/bin/env Rscript

main <- function(input, output, log, threads, wildcards) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(BiocParallel)

    library(scran)

    sce <- readRDS(input$rds)

    res <- pairwiseWilcox(
        x = logcounts(sce),
        groups = sce$Cluster,
        direction = as.character(wildcards$direction),
        lfc = as.numeric(wildcards$lfc),
        BPPARAM = MulticoreParam(workers = threads)
    )

    res$gene.names <- setNames(rowData(sce)$Symbol, rowData(sce)$ID)

    res$statistics <- lapply(res$statistics, function(x) DataFrame(gene.id = rownames(x), gene.name = res$gene.names[rownames(x)], x, row.names = rownames(x)))

    saveRDS(res, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@log, snakemake@threads, snakemake@wildcards)
