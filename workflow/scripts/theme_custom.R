theme_custom <- function() {

    # Return custom theme

    theme_bw() +
    theme(
        axis.title.x = element_text(margin = unit(c(1, 0, 0, 0), "lines")),
        axis.title.y = element_text(margin = unit(c(0, 1, 0, 0), "lines")),
    )

}