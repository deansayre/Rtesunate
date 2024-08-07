#' @title get_jams
#' @description Let's ROCK!
#'
#' @return Righteous tunes
#' @export
#'
#' @param secret_code Accepts a secret code, if you know any (in quotes)
#'
#' @examples
#' get_jams()

get_jams <- function(secret_code = NULL){
  if (!is.null(secret_code)){
        if (secret_code == "dean_al"){
          browseURL("https://www.youtube.com/watch?v=eYwuCpOHKc4")
        } else if (secret_code == "dante. gone but not forgotten"){
      browseURL("https://www.youtube.com/watch?v=u5o582N3wOQ")
    } else if (secret_code == "please don't confront me with my failures. i had not forgotten them."){
      browseURL("https://www.youtube.com/watch?v=1vxQs84FMWQ")
    } else if (secret_code == "trial by fire"){
      browseURL('https://www.youtube.com/watch?v=jPsZqDKwCQo&list=OLAK5uy_lHJ2orORd04rtdu-cUo-fnUkOYNBCtwyM&index=2')
    } else if (secret_code == "hallender mix"){
      vect <- c("https://www.youtube.com/watch?v=0R7wpcw1Z4A",
                "https://www.youtube.com/watch?v=Kh8-r6O43Rw",
                "https://www.youtube.com/watch?v=c9zteYU7jSU")

      x1 <- sample(vect, 1)
      browseURL(x1)}  else{cat("Ah ah ah... you didn't say the magic word\n
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
                  Ah ah ah... you didn't say the magic word")
          a <- magick::image_read(system.file("secret_code.gif",
                                              package="Rtesunate"))
          print(a, info = FALSE)}
  }
  else{
  vect <- c("https://www.youtube.com/watch?v=qORYO0atB6g",
            "https://www.youtube.com/watch?v=5ViMA_qDKTU",
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
            "https://www.youtube.com/watch?v=R8OGzqrsGTE",
            "https://www.youtube.com/watch?v=Hfc2tf88tJU",
            "https://www.youtube.com/watch?v=DNIAHS4-YxM",
            "https://www.youtube.com/watch?v=1vxQs84FMWQ")

  x1 <- sample(vect, 1)
  browseURL(x1)
  }
}
