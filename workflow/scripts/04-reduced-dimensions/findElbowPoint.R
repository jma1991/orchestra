#!/usr/bin/env Rscript

findElbowPoint <- function(x, y) {
    
    # Max values to create line
    max_x_x <- max(x)
    max_x_y <- y[which.max(x)]
    max_y_y <- max(y)
    max_y_x <- x[which.max(y)]
    max_df <- data.frame(x = c(max_y_x, max_x_x), y = c(max_y_y, max_x_y))
    
    # Creating straight line between the max values
    fit <- stats::lm(max_df$y ~ max_df$x)
    
    # Distance from point to line
    distances <- c()
    for (i in 1:length(x)) {
        distances <- c(distances, abs(stats::coef(fit)[2]*x[i] - y[i] + stats::coef(fit)[1]) / sqrt(stats::coef(fit)[2]^2 + 1^2))
    }
    
    # Max distance point
    K <- x[which.max(distances)]
    return(K)

}

main <- function(input, output) {

    pkg <- c("SingleCellExperiment")

    lib <- lapply(pkg, library, character.only = TRUE)

    dim <- readRDS(input$rds)

    var <- attr(dim, "percentVar")

    idx <- seq_along(var)
    
    num <- findElbowPoint(idx, var)

    saveRDS(num, output$rds)

}

main(snakemake@input, snakemake@output)