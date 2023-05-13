#' Similar to act_svyciprop, but able to spit out a dataframe containing estimates
#'  for multiple variables/responses. Variables and responses are input as vectors.
#'
#' @param variable_vect_name a vector of variables of interest (in quotes)
#' @param response a vector of response of intersest for each entry in varibale_vect_name.
#' Note that these are paired by order and that the number of entries in
#' variable_vect_name and response must be equal
#' @param design svydesign object containing the variables/values. Can only take one svydesign.
#' To call multiple svydesigns in parallel, see purrr package or Rtesunate::act_svyciprop_list()
#' @param ... arguments passed to svyciprop
#'
#' @import purrr
#'
#' @return A mutli-row dataframe providing the variable names, weighted mean proportions of
#' observations taking value of interest, cluster-adjusted 95% CIs, and counts
#' as n/N character variable (N is all non-NA values).
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' variable_vect_name <- c("cname", "sch.wide", "awards")
#' response <- c("Los Angeles", "Yes", "Yes")
#' act_svyciprop_tbl(variable_vect_name, response, design)
#'
#' @export
act_svyciprop_tbl <- function(variable_vect_name,
                              response, design_obj, ...){
  purrr::map2_dfr(variable_vect_name, response, function(y,z) act_svyciprop(y,
                                                                     cond = z,
                                                                     design_obj,
                                                                     ...))
}

