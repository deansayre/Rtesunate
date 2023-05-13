#' A dataframe with weighted mean, cluster-adjusted 95% CI, and
#' unweighted n/N observation counts for every variable
#' within a svydesign.
#'
#' @import dplyr
#' @import tidyselect
#'
#'
#' @param design svydesign object containing the variable/value
#' @param drop vector of variables to drop from output dataframe
#'
#' @return A dataframe providing the variable name, value, weighted mean proportion of
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

act_fullmonty <- function(design, drop = NULL){
  if (!is.null(drop)){
    df <- design[["variables"]] %>%
      select(where(is.factor) | where(is.character)) %>%
      select(-all_of(drop))
  }

  else{
    df <- design[["variables"]] %>%
      select(where(is.factor) | where(is.character))
  }

  var <- names(df)

  value <- map(var, ~unique(eval(sym(.x), envir = df))) %>%
    purrr::set_names(var) %>%
    enframe() %>%
    unnest_longer(value) %>%
    drop_na(value)

  a <- Rtesunate::act_svyciprop_tbl(value$name, value$value, design) %>%
    bind_cols(value$value) %>%
    rename(value = 6,
           variable = rowname) %>%
    mutate(type = "categorical") %>%
    relocate(value, .after = variable) %>%
    relocate(type, .after = value)

  return(a)
}
