#' @title act_show_colors
#' @description Let's ROCK!
#'
#' @return Righteous colors
#'
#' @param palette Palette name (in quotes)
#'
#' @examples
#' act_show_colors("aladdin_sane")
#'
#'
#'
#' @export

act_show_colors <- function(palette){
  if (palette == "purple_rain"){
  cat("Purify your graphs in the waters of Lake Minnetoka")
  a <- magick::image_scale(magick::image_read(system.file("purple_rain.png",
                                      package="Rtesunate")),
                           grDevices::dev.size("px"))
  print(a, info = FALSE)
} else if(palette == "aladdin_sane"){
  cat("Panic in Detroit, I asked for an auto. Graph.")
  a <- magick::image_scale(magick::image_read(system.file("aladdin_sane.png",
                                      package="Rtesunate")),
                           grDevices::dev.size("px"))

  print(a, info = FALSE)
} else if(palette == "sgt_pepper"){
  cat("Picture your graphs in a boat on a river.\n
       With tangerine trees and marmalade skies")
  a <- magick::image_scale(magick::image_read(system.file("sgt_pepper.png",
                                      package="Rtesunate")),
                           grDevices::dev.size("px"))
  print(a, info = FALSE)
} else if(palette == "hello_nasty"){
  cat("Another dimension, another dimension\n
Another dimension, another dimension\n
Another dimension, another dimension\n
Another dimension, another dimension\n
Another dimension, another dimension\n
Another dimension")
  a <- magick::image_scale(magick::image_read(system.file("hello_nasty.png",
                                      package="Rtesunate")),
                           grDevices::dev.size("px"))
  print(a, info = FALSE)
} else if(palette == "unknown_pleasures"){
  cat("British. Post-punk. Depressing.")
  a <- magick::image_scale(magick::image_read(system.file("unknown_pleasures.png",
                                                          package="Rtesunate")),
                           grDevices::dev.size("px"))
  print(a, info = FALSE)
} else if(palette == "ok_computer"){
  cat("Make your graphs fitter. Happier. More productive.")
  a <- magick::image_scale(magick::image_read(system.file("okcomputer.png",
                                                          package="Rtesunate")),
                           grDevices::dev.size("px"))
  print(a, info = FALSE)
}else{scales::show_col(mal_pal[[palette]])}
}
