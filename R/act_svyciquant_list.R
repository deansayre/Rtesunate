#' Listified version of act_svyciquant_tbl, allowing parallel use with multiple
#' svydesigns. Useful when survey conducted at multiple times and/or there are
#' multiple subsets of interest. Variables are input as vectors;
#' svydesigns are input as lists
#'
#' @param variable_vect_name a vector of variables of interest (in quotes)
#' @param design_obj_list list of svydesign object containing the variables/values.
#' @param ... arguments passed to svyciprop
#'
#' @import purrr
#'
#' @return A dataframe providing the variable names, weighted mean proportions of
#' observations taking value of interest, cluster-adjusted 95% CIs, and counts
#' as n/N character variable (N is all non-NA values). Results from different
#' svydesigns appear as columns in the order in which they are called.
#' @export
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' design1 <- subset(design, cname == "Los Angeles")
#' design2 <- subset(design, cname == "San Diego")
#' variable_vect_name <- c("api00", "snum")
#' act_svyciquant_list(variable_vect_name, list(design1, design2))
#' act_svyciquant_list(variable_vect_name, list(design1, design2), level = 0.99)
act_svyciquant_list <- function(variable_vect_name,
                               design_obj_list,
                               ...){purrr::list_cbind(purrr::map(design_obj_list,
                                                                 function (x) purrr::map_dfr(variable_vect_name,
                                                                                              function(y) act_svyciquant(y,
                                                                                                                         x,
                                                                                                                          ...))))
}
