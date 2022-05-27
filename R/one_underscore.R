#' one_underscore
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
one_underscore <- function(x){
  withr::local_options(.new = list(warn = -1))
  if (is.character(x)){
    if(str_count(x, "_")==1){
      a <- str_replace(x, "_", ".")
      if (is_all_numeric(a)){
        as.numeric(a)
        return(a)
      }
      else {return(a)}
    }
    else {return(x)}
  }
  else {return(x)}
}
