#' A creates a dataframe with weighted means and cluster adjusted 95%
#' confidence intervals for specific responses for categorical data in svydesign
#'
#' @param x variable of interest (in quotes)
#' @param term the value for which estimates are desired (in quotes)
#' @param design svydesign object containing the variable/value
#'
#' @return A dataframe providing the mean, 95% CI
#' @export
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_row("cname", "Los Angeles", design)


act_row <- function(x, term, design){
  term_sym <- rlang::sym(term)
  form <- paste0("~",x,"==", "'",term_sym, "'")

  a <- try(stats::confint(survey::svymean(as.formula(form), design = design,
                                          na.rm=TRUE)))
  if (inherits(a, "try-error")) {
    b <- tibble::tribble(~rowname, ~mean,  ~`2.5 %`,  ~`97.5 %`,
                         x,    NA_real_, NA_real_,NA_real_)}
  else{

    a <- stats::confint(survey::svymean(as.formula(form), design = design,
                                        na.rm=TRUE)) %>%
      as.data.frame() %>%
      tibble::rownames_to_column() %>%
      dplyr::filter(stringr::str_detect(rowname, "TRUE")) %>%
      dplyr::mutate(rowname = stringr::str_remove(rowname, "==.*"))

    b <- survey::svymean(as.formula(form), design = design, na.rm=TRUE) %>%
      as.data.frame() %>%
      tibble::rownames_to_column() %>%
      dplyr::filter(stringr::str_detect(rowname, "TRUE")) %>%
      dplyr::mutate(rowname = stringr::str_remove(rowname, "==.*")) %>%
      dplyr::select(-SE) %>%
      dplyr::left_join(a) %>%
      dplyr::mutate(rowname = stringr::str_trim(rowname))}
  return(b)
}
