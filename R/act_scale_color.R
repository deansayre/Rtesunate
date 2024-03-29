#' Colors ggplots with palettes based on pre-fab palettes included in this
#' package, at no extra cost!
#'
#'
#' @param palette name of pre-fab palette on which to base output (in quotes)
#' @param reverse boolean variable defaulting to FALSE. Set to TRUE if want to
#' reverse
#' @param ... arguments passed to discrete_scale or scale_fill_gradientn, which
#' do the work under the hood.
#'
#'
#' @return A ggplot with colors that ROCK (or that are sort of boring, depending
#' on the pre-fab palette chosen).
#'
#'
#' @examples
#' data("iris")
#'
#' library(tidyverse)
#'
#' ggplot(iris)+
#'  geom_point(aes(x = Sepal.Width, y = Petal.Length, color = Species))+
#'  act_scale_color("hello_nasty")
#' @export


act_scale_color <- function(palette = "ncezid",
                            discrete = TRUE,
                            reverse = FALSE,
                            ...) {

  if (discrete == TRUE) {
    ggplot2::discrete_scale("colour", "mal_pal",
                            palette = act_pal(palette = palette,
                                              reverse = reverse),
                            ...)
  } else {
    ggplot2::scale_color_gradientn(colours = act_pal(palette = palette,
                                                     reverse = reverse)(256),
                                   ...)
  }
}
