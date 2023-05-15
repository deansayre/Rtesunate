#' @title get_jams
#' @description Let's ROCK!
#'
#' @return Righteous tunes
#' @export
#'
#' @examples
#' get_jams()

get_jams <- function(secret_code = NULL){
  if (!is.null(secret_code)){
        if (secret_code == "dean_al"){
          browseURL("https://www.youtube.com/watch?v=eYwuCpOHKc4")
        }
        else{stop("Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n
                  Ah ah ah... you didn't say the magic word\n")}
      }
  else{
  vect <- c("https://www.youtube.com/watch?v=5ViMA_qDKTU",
            "https://www.youtube.com/watch?v=YVo4EGXeUUI",
            "https://www.youtube.com/watch?v=MZlH0LnRQhs",
            "https://www.youtube.com/watch?v=9oI27uSzxNQ",
            "https://www.youtube.com/watch?v=T-lBGT8Eues",
            "https://www.youtube.com/watch?v=6B702b-8_gA",
            "https://www.youtube.com/watch?v=BBXFVFHdmbs",
            "https://www.youtube.com/watch?v=eYwuCpOHKc4",
            "https://www.youtube.com/watch?v=v6zN5CFL4fs",
            "https://www.youtube.com/watch?v=-9prpAv6kvo",
            "https://www.youtube.com/watch?v=2EntxPIULUI",
            "https://www.youtube.com/watch?v=uM1fSjwB9cw",
            "https://www.youtube.com/watch?v=PMavhk16FJU",
            "https://www.youtube.com/watch?v=lXgkuM2NhYI",
            "https://www.youtube.com/watch?v=6B702b-8_gA",
            "https://www.youtube.com/watch?v=702s_xuxD9g",
            "https://www.youtube.com/watch?v=Zj9Sv1JpmPs",
            "https://www.youtube.com/watch?v=Ve9Y-dl40sQ",
            "https://www.youtube.com/watch?v=cP3iKrMDE-g",
            "https://www.youtube.com/watch?v=R8OGzqrsGTE")

  x1 <- sample(vect, 1)
  browseURL(x1)
  }
}
