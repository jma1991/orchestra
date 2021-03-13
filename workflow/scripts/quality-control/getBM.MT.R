#!/usr/bin/env Rscript

useEnsembl.dataset <- function(x) {

    # Return name of dataset
    
    x <- tolower(x)
    
    x <- strsplit(x, "\\s")
    
    x.genus <- x[[1]][1]

    x.species <- x[[1]][2]

    x.genus.initial <- substr(x.genus, 1, 1)

    x <- paste0(x.genus.initial, x.species)

    x <- paste(x, "gene", "ensembl", sep = "_")

    return(x)

}

main <- function(input, output, params, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function

    library(biomaRt)

    use <- useEnsembl(
        biomart = "genes",
        dataset = useEnsembl.dataset(params$organism)
    )
    
    get <- getBM(
        attributes = "ensembl_gene_id",
        filters = "chromosome_name",
        values = "MT",
        mart = use
    )

    ids <- get$ensembl_gene_id

    saveRDS(ids, file = output$rds)

}

main(snakemake@input, snakemake@output, snakemake@params, snakemake@log)