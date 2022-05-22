#' one_underscore
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
one_underscore <- function(x){
  if (is.character(x) & !is.na(x)){
    if(str_count(x, "_")==1){
      a <- str_replace(x, "_", ".")
      if(is_all_numeric(a)){as.numeric(a)}
      return(a)
    }
    else return(x)}
  else return(x)}