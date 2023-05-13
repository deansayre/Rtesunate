#' A creates a dataframe showing observation counts used for a mean/CI
#' of selected variable within a svydesign (quantitative). Best used in conjunction with Rtesunate::act_rows().
#' (See act_svyciprop family of functions which combines the two)
#'
#' @param x variable of interest (in quotes)
#' @param design svydesign object containing the variable/value
#'
#' @import rlang
#' @import tibble
#' @import dplyr
#' @import tidyr
#'
#' @return A dataframe showing counts of observations used to calculate the mean/CI
#' @export
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_row("cname", "Los Angeles", design)


act_ns_quant <- function(x, design){
  x1 <- rlang::sym(x)

  df <- Rtesunate::act_extract_svydesign(design)

  test <- df %>%
    dplyr::summarise(n = sum(!is.na(!!x1)))


  c <- tibble::tibble(ind = base::paste0(x1),
                      n_unweighted=as.character(test$n))

  return(c)
}


