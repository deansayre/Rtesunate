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
#' @importFrom ggplot2 scale_fill_manual discrete_scale scale_fill_gradientn
#'
#' @examples
#' data("iris")
#' library(tidyverse)
#' ggplot(iris)+
#'   geom_histogram(aes(x = Petal.Length, fill = Species))+
#'   act_scale_fill("usaid")

#' @export


act_scale_fill <- function(palette = "ncezid",
                           discrete = TRUE,
                           reverse = FALSE,
                           ...) {
  if (discrete ==TRUE) {
    ggplot2::discrete_scale("fill", "mal_pal",
                   palette = act_pal(palette = palette, reverse = reverse),
                   ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = act_pal(palette = palette,
                                           reverse = reverse)(256),
                         ...)
  }
}
