#' A creates a one line dataframe with weighted mean, cluster-adjusted 95% CI, and
#' observation counts for selected variable within a svydesign.
#'
#'
#' @param x variable of interest (in quotes)
#' @param design svydesign object containing the variable/value
#' @param ... arguments passed to stats::confint
#'
#'
#' @return A dataframe providing the variable name, weighted mean of
#' a quantitative variable of interest, cluster-adjusted 95% CI, and counts
#' as character variable (all non-NA values).
#'
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_svyciquant("api00", design)
#' act_svyciquant("api00", design, level = 0.75)


#' @export

act_svyciquant <- function(x, design, ...){
  a <- Rtesunate::act_row_quant(x = x, design = design, ...)
  c <- Rtesunate::act_ns_quant(x = x, design = design)
  design_name <- deparse(substitute(design))

  d <- dplyr::left_join(a,c, by = c("rowname" = "ind")) %>%
    dplyr::mutate(dplyr::across(tidyselect::where(is.numeric), ~base::round(.x,
                                                                            digits = 1)))%>%
    dplyr::rename(ci_low = 4,
                  ci_high = 5) %>%
    dplyr::rename_with(.cols = everything(), ~paste0(., "_", design_name))
  return(d)
}
