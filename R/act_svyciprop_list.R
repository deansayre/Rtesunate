#' Listified version of act_svyciprop_tbl, allowing parallel use with multiple
#' svydesigns. Useful when survey conducted at multiple times and/or there are
#' multiple subsets of interest. Variables and responses are input as vectors;
#' svydesigns are input as lists
#'
#' @param variable_vect_name a vector of variables of interest (in quotes)
#' @param response a vector of response of intersest for each entry in varibale_vect_name.
#' Note that these are paired by order and that the number of entries in
#' variable_vect_name and response must be equal
#' @param design_obj_list list of svydesign object containing the variables/values.
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
#' variable_vect_name <- c("comp.imp", "sch.wide", "awards")
#' response <- c("Yes", "Yes", "Yes")
#' act_svyciprop_list(variable_vect_name, response, list(design1, design2))
act_svyciprop_list <- function(variable_vect_name,
                               response, design_obj_list){purrr::list_cbind(purrr::map(design_obj_list,
                                                                    function (x) purrr::map2_dfr(variable_vect_name,
                                                                                          response,
                                                                                          function(y,z) Rtesunate::act_svyciprop (y,
                                                                                                                       cond = z,
                                                                                                                       x))))
}
