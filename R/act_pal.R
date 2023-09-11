#' Generates a function to create a palette based on those included in the
#' package.
#'
#'
#' @param palette name of pre-fab palette on which to base output (in quotes)
#' @param reverse boolean variable defaulting to FALSE. Set to TRUE if want to
#' reverse
#' @param ... arguments passed to colorRampPalette
#'
#'
#' @return A function which outputs a palette of desired length, interpolating
#' between stated colors if necessary.
#'
#'
#' @examples
#' pal_5 <- act_pal("aladdin_sane")(5)

#' @export


act_pal <- function(palette = "ncezid", reverse = FALSE, n, ...) {
  pal <- mal_pal[[palette]]

  if (reverse) pal <- rev(pal)

  if (n <= length(pal)){
    return(pal[c(1:n)])
  } else {colorRampPalette(pal, ...)(n)}

}



