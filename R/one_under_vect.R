#' act_one_under
#'
#' @param x vector to assess for structure
#'
#' @return Converts character vectors containing entries that all have one or
#' fewer underscores to numeric after substituting a decimal for the underscore
#' @export
#'
#' @examples
#' num_vector <- act_one_under(x)


act_one_under <- function(x){
#  withr::local_options(.new = list(warn = -1))
  if (is.character(x)){
    vec <- base::vector(mode = 'integer', length = length(x))
    for (i in seq_along(vec)){
      vec[[i]] <- stringr::str_count(x[[i]], "_")
    }
    if(all(vec <= 1, na.rm = TRUE)){
      a <- stringr::str_replace(x, "_", ".")
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
