#' A dataframe with weighted mean, cluster-adjusted 95% CI, and
#' unweighted n/N observation counts for every variable within a svydesign.
#' A blunt tool for quick exploration lacking some of the capabilities/finesse
#' of act_svyciprop and act_svyciquant.
#'
#'
#'
#' @param design svydesign object containing the variable/value
#' @param drop vector of variables to drop from output dataframe
#' @param level confidence level for CIs passed to both categorical and
#' quantitative variables expressed as a fraction, i.e., '0.xx'
#' @param method method used for categorical CIs. Options: "logit" (default),
#' "likelihood", "asin", "beta", "mean", "xlogit". See svyciprop documentation
#' for more details.
#'
#' @return A dataframe providing the variable name, value, weighted mean proportion of
#' all observations, cluster-adjusted 95% CI, and counts
#' as n/N character variable (N is all non-NA values).
#'
#'
#' @examples
#' using api data from survey package
#' data(api)
#' design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
#' act_fullmonty(design)
#' act_fullmonty(design, level = 0.99, method = "mean")

#' @export

act_fullmonty <- function(design, drop = NULL, level = 0.95,
                          method = "logit"){
  if (!is.null(drop)){
    df <- design[["variables"]] %>%
      dplyr::select(-tidyselect::all_of(drop)) %>%
      dplyr::select(tidyselect::where(is.factor) | tidyselect::where(is.character))

    df2 <- design[["variables"]] %>%
      dplyr::select(-tidyselect::all_of(drop)) %>%
      dplyr::select(tidyselect::where(is.numeric))
  }
  else{
    df <- design[["variables"]] %>%
      dplyr::select(tidyselect::where(is.factor) | tidyselect::where(is.character))

    df2 <- design[["variables"]] %>%
      dplyr::select(tidyselect::where(is.numeric))

    }

  var <- names(df)

  value <- purrr::map(var, ~unique(eval(rlang::sym(.x), envir = df))) %>%
    purrr::set_names(var) %>%
    tibble::enframe() %>%
    tidyr::unnest_longer(value) %>%
    tidyr::drop_na(value)

  a <- Rtesunate::act_svyciprop_tbl(value$name, value$value, design, method = method,
                                    level = level) %>%
    dplyr::rename(count = 6) %>%
    dplyr::mutate(type = "categorical") %>%
    dplyr::relocate(type, .after = 2)

  var2 <- names(df2)

  b <- Rtesunate::act_svyciquant_tbl(var2, design, level = level) %>%
    dplyr::rename(count = 6) %>%
    dplyr::mutate(type = "quantitative") %>%
    dplyr::relocate(type, .after = 2)

c <- dplyr::bind_rows(a,b)

df3 <- names(design[["variables"]]) %>%
  as.data.frame() %>%
  dplyr::rename(variable = 1) %>%
  dplyr::left_join(rename(c, variable = 1), by = "variable")

return(df3)
             }
