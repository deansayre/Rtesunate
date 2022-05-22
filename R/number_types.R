#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
is_all_numeric <- function(x) {
  !any(is.na(suppressWarnings(as.numeric(na.omit(x))))) & is.character(x)
}

#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
is_wholenumber <- function(x){
  if (is.numeric(x)){
    a <- x == round(x)
    return(a)
  }
  else {FALSE}
}


#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
is_all_whole <- function(x){
  ans = ifelse(all(is_wholenumber(x), na.rm = T), T, F)
  return(ans)
}
