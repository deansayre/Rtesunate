#' Similar to act_svyciquant, but able to spit out a dataframe containing estimates
#'  for multiple variables. Variables are input as vectors.
#'
#' @param variable_vect_name a vector of variables of interest (in quotes)
#' @param design svydesign object containing the variables/values. Can only take one svydesign.
#' To call multiple svydesigns in parallel, see purrr package or Rtesunate::act_svyciquant_list()
#' @param ... arguments passed to svyciquant
#'
#' @import purrr
#'
#' @return A mutli-row dataframe providing the variable names, weighted means of
#' observations of interest, cluster-adjusted 95% CIs, and counts of all non-NA values.
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_svyciquant_tbl(c("api00", "snum"), design)
#' act_svyciquant_tbl(c("api00", "snum"), design, level = 0.99)
#'
#' @export
act_svyciquant_tbl <- function(variable_vect_name,
                              design_obj, ...){
  purrr::map_dfr(variable_vect_name, function(y,z) act_svyciquant(y, design_obj,
                                                                            ...))
}
