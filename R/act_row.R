#' A creates a dataframe with weighted means and cluster adjusted 95%
#' confidence intervals for specific responses for categorical data in svydesign
#'
#' @param x variable of interest (in quotes)
#' @param term the value for which estimates are desired (in quotes)
#' @param design svydesign object containing the variable/value
#' @param ... confidence interval options passed to svyciprop function. See
#' svyciprop documentation for information
#'
#' @import rlang
#' @import survey
#' @import tibble
#' @import dplyr
#' @import tidyr
#'
#' @return A dataframe providing the mean, 95% CI
#' @export
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_row("cname", "Los Angeles", design)


act_row <- function(x, term, design, ...){
  term_sym <- rlang::sym(term)
  form <- paste0("~",x,"==", "'",term_sym, "'")

  a <- try(survey::svyciprop(as.formula(form), design = design, ...,
                             na.rm=TRUE))
  if (inherits(a, "try-error")) {
    c <- tibble::tribble(~rowname, ~value,  ~mean,  ~`2.5%`,  ~`97.5%`,
                         x,  term,  NA_real_, NA_real_,NA_real_)}
  else{

    a <- survey::svyciprop(as.formula(form), design = design, ...,
                           na.rm=TRUE)

    b <- attr(a, "ci") %>%
      as.data.frame()%>%
      tibble::rownames_to_column() %>%
      tidyr::pivot_wider(names_from = rowname, values_from = 2)

    c <- a %>%
      as.vector() %>%
      as.data.frame() %>%
      dplyr::rename(mean = 1) %>%
      dplyr::bind_cols(b) %>%
      dplyr::mutate(rowname = x,
                    value = term) %>%
      dplyr::relocate(rowname, value)
  }
  return(c)
}
