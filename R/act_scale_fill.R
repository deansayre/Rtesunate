#' Colors ggplots with palettes based on pre-fab palettes included in this
#' package, at no extra cost!
#'
#'
#' @param palette name of pre-fab palette on which to base output (in quotes)
#' @param reverse boolean variable defaulting to FALSE. Set to TRUE if want to
#' reverse
#' @param discrete boolean variable defaulting to TRUE. Set to FALSE if want to
#' generate a continuous palette
#' @param ... arguments passed to discrete_scale or scale_fill_gradientn, which
#' do the work under the hood.
#'
#'
#'
#' @return A ggplot with colors that ROCK (or that are sort of boring, depending
#' on the pre-fab palette chosen).
#'
#'
#' @examples
#' pal_5 <- act_pal("aladdin_sane")(5)

#' @export


act_scale_fill <- function(palette = "ncezid",
                           discrete = TRUE,
                           reverse = FALSE, ...) {
  pal <- mal_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", name = NULL, palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
