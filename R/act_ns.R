#' A creates a dataframe with unweighted n/N observation counts for value of interest
#' of selected variable within a svydesign (categorical). Best used in conjunction with Rtesunate::act_rows().
#' (See act_svyciprop family of functions which combines the two)
#'
#' @param x variable of interest (in quotes)
#' @param cond the value for which estimates are desired (in quotes)
#' @param design svydesign object containing the variable/value
#'
#' @return A dataframe providing the counts as n/N character variable (N is all non-NA values)
#' @export
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_ns("cname", "Los Angeles", design)



act_ns <- function(x, cond, design){
  x1 <- rlang::sym(x)

  df <- Rtesunate::act_extract_svydesign(design)

  test <- df %>%
    dplyr::count(!!x1) %>%
    dplyr::filter(!is.na(!!x1))

  test1 <-  test %>%
    dplyr::filter(!!x1 == cond)

  a <- dplyr::pull(test1, var = n)

  if(is.null(a)){a <- 0}      # new to solve issue with blanks
  else {a <- a}               # new to solve issue with blanks

  b <- base::sum(test$n)

  c <- tibble::tibble(ind = base::paste0(x1),
              n_unweighted=base::paste0(a, "/", b)) %>%
    dplyr::mutate(n_unweighted = base::ifelse(stringr::str_detect(n_unweighted, "/0"), NA_character_,
                                 n_unweighted))

  return(c)
}
