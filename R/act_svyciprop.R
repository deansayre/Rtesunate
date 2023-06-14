#' A creates a one line dataframe with weighted mean, cluster-adjusted 95% CI, and
#' unweighted n/N observation counts for value of interest for selected variable
#' within a svydesign.
#'
#'
#' @param x variable of interest (in quotes)
#' @param cond the value for which estimates are desired (in quotes)
#' @param design svydesign object containing the variable/value
#' @param ... arguments passed to svyciprop
#'
#'
#' @return A dataframe providing the variable name, weighted mean proportion of
#' observations taking value of interest, cluster-adjusted 95% CI, and counts
#' as n/N character variable (N is all non-NA values).
#'
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_svyciprop("cname", "Los Angeles", design)

#' @export

act_svyciprop <- function(x, cond, design, ...){
  a <- Rtesunate::act_row(x = x, term = cond, design = design, ...)
  c <- Rtesunate::act_ns(x = x, cond = cond, design = design)
  design_name <- deparse(substitute(design))

  d <- dplyr::left_join(a,c, by = c("rowname" = "ind")) %>%
    dplyr::mutate(dplyr::across(tidyselect::where(is.numeric), ~base::round(100*.x,
                                                                            digits = 1)))%>%
    dplyr::rename(ci_low = 4,
           ci_high = 5) %>%
    dplyr::mutate(ci_low = max(ci_low, 0),
           ci_high = min(ci_high, 100)) %>%
    dplyr::rename_with(.cols = everything(), ~paste0(., "_", design_name))
  return(d)
}
