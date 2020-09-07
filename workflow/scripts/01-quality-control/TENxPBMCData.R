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
    
    saveRDS(sce, file = output$rds)

}

main(snakemake@input, snakemake@output)