#!/usr/bin/env Rscript

main <- function(input, output) {

    library(TENxPBMCData)
    
    sce <- TENxPBMCData(dataset = "pbmc3k")
    
    rowData(sce) <- DataFrame(
        ID = rowData(sce)$ENSEMBL_ID,
        Symbol = rowData(sce)$Symbol_TENx,
        row.names = rowData(sce)$ENSEMBL_ID
    )
    
    colData(sce) <- DataFrame(
        Sample = colData(sce)$Sample,
        Barcode = colData(sce)$Sequence,
        row.names = colData(sce)$Sequence
    )

    library(EnsDb.Hsapiens.v86)
    
    chr <- mapIds(EnsDb.Hsapiens.v86, keys = rownames(sce), keytype = "GENEID", column = "SEQNAME")

    mit <- chr == "MT"

    mit[is.na(mit)] <- FALSE

    rowData(sce)$MT <- mit

    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output)