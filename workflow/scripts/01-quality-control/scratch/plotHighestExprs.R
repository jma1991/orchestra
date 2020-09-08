#!/usr/bin/env Rscript


func <- function(x) {

    mat <- assay(x, "counts", withDimnames = FALSE)
    
    ave <- rowSums(mat)
    
    idx <- order(ave, decreasing = TRUE)

    chosen <- head(idx, n = 50)


    sub_mat <- exprs_mat[chosen,,drop=FALSE]
    sub_ave <- ave_exprs[chosen]


        total_exprs <- sum(ave_exprs)
        top_pctage <- 100 * sum(sub_ave) / total_exprs
        sub_mat <- 100 * sweep(sub_mat, 2, colSums2(exprs_mat), "/", check.margin=FALSE)



}





main <- function(input, output) {

    library(scater)

    sce <- readRDS(input$rds)

    plt <- plotHighestExprs(sce)

    ggsave(output$pdf, plot = plt, width = 5, height = 5)

}

main(snakemake@input, snakemake@output)