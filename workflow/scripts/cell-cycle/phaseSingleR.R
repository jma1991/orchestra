#!/usr/bin/env Rscript

main <- function(input, output) {

    pkg <- c("SingleCellExperiment", "SingleR")

    lib <- lapply(pkg, library, character.only = TRUE)

    sce <- readRDS(input$rds)

    ref <- BuettnerESCData()

    ##
    
    id1 <- rownames(sce)

    id2 <- rownames(ref)

    id3 <- select(org.Mm.eg.db, keytype = "GOALL", keys = "GO:0007049", columns = "ENSEMBL")[,"ENSEMBL"]

    ids <- Reduce(intersect, list(id1, id2, id3))


    ##

    ref <- logNormCounts(ref)

    mat <- logcounts(ref)

    res <- pairwiseWilcox(mat, ref$phase, direction = "up", subset.row = ids)
    
    sig <- getTopMarkers(res$statistics, res$pairs)

    ##
    
    out <- SingleR(sce, ref, label = ref$phase, genes = ids)

    sce$phase <- out$labels

    saveRDS(sce, output$rds)   
    
}

main(snakemake@input, snakemake@output, snakemake@params)