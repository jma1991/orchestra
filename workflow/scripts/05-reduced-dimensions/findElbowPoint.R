#!/usr/bin/env Rscript

ElbowFinder <- function(x, y) {
    
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

main <- function(input, output, log) {

    # Log function

    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    # Script function
        
    var <- readLines(input$txt)
    
    num <- ElbowFinder(seq_along(var), as.numeric(var))

    writeLines(as.character(num), con = output$txt)

}

main(snakemake@input, snakemake@output, snakemake@log)