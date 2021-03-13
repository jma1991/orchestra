#!/usr/bin/env Rscript

annotateBMFeatures.dataset <- function(x) {

    # Return name of dataset
    
    x <- tolower(x)
    
    x <- strsplit(x, "\\s")
    
    x.genus <- x[[1]][1]

    x.species <- x[[1]][2]

    x.genus.initial <- substr(x.genus, 1, 1)

    x <- paste0(x.genus.initial, x.species)

    x <- paste(x, "gene", "ensembl", sep = "_")

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(scater)

    sce <- readRDS(input$rds)

    ann <- annotateBMFeatures(
        ids = rowData(sce)$ID,
        dataset = annotateBMFeatures.dataset(params$organism)
    )
    
    colnames(ann) <- c("ID", "Symbol", "Chromosome", "Biotype", "Start", "End")
    
    saveRDS(ann, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)