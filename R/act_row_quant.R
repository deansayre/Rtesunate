#' Calculates weighted mean and cluster-adjusted confidence interval for quantitative
#' variable in svydesign object
#'
#' @param x variable of interest (in quotes)
#' @param design_object svydesign object of interest in functions act_row, act_ns, etc
#' @param ... arguments passed to stats::confint. Most useful if need to change
#' from 95% CI (default) to a different level of confidence; entered as
#' 'level = 0.xx'
#'
#'
#' @return Dataframe with one row indicating variable name, survey-weighted mean
#' and confidence interval
#'
#' @examples

#' using api data from survey package
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_row_quant("api00", design)
#' act_row_quant("api00", design, level = 0.99)
#'
#' @import stats
#' @import survey
#' @import tibble
#' @import dplyr
#'
#' @export
act_row_quant <- function(x, design, ...){
  form <- paste0("~",x)

  a <- stats::confint(survey::svymean(as.formula(form), design = design,
                                      na.rm=TRUE), ...) %>%
    as.data.frame() %>%
    tibble::rownames_to_column()

  b <- survey::svymean(as.formula(form), design = design, na.rm=TRUE) %>%
    as.data.frame() %>%
    tibble::rownames_to_column() %>%
    dplyr::select(-3) %>%
    dplyr::left_join(a, by = "rowname") %>%
    dplyr::mutate(rowname = x,
                  value = NA_character_) %>%
    dplyr::relocate(rowname, value)
  return(b)
}
