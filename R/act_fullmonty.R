#' A dataframe with weighted mean, cluster-adjusted 95% CI, and
#' unweighted n/N observation counts for every variable
#' within a svydesign.
#'
#' @import dplyr
#' @import tidyselect
#' @import purrr
#' @import tibble
#' @import tidyr
#'
#'
#' @param design svydesign object containing the variable/value
#' @param drop vector of variables to drop from output dataframe
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
#' act_svyciprop("cname", "Los Angeles", design)

#' @export

act_fullmonty <- function(design, drop = NULL){
  if (!is.null(drop)){
    df <- design[["variables"]] %>%
      dplyr::select(tidyselect::where(is.factor) | tidyselect::where(is.character)) %>%
      dplyr::select(-tidyselect::all_of(drop))

    df2 <- design[["variables"]] %>%
      dplyr::select(tidyselect::where(is.numeric)) %>%
      dplyr::select(-tidyselect::all_of(drop))
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

  a <- Rtesunate::act_svyciprop_tbl(value$name, value$value, design) %>%
    dplyr::bind_cols(value$value) %>%
    dplyr::rename(value = 6
         #  variable = rowname
           ) %>%
    dplyr::mutate(type = "categorical")# %>%
  #  dplyr::relocate(value, .after = variable) %>%
  #  dplyr::relocate(type, .after = value)

  var2 <- names(df2)

  b <- Rtesunate::act_svyciquant_tbl(var2, design) %>%
    dplyr::rename(value = 6
                  #variable = rowname
                  ) %>%
    dplyr::mutate(value = NA_character_) %>%
    dplyr::mutate(type = "quantitative") #%>%
  #  dplyr::relocate(value, .after = variable) %>%
  #  dplyr::relocate(type, .after = value)

c <- dplyr::bind_rows(a,b)
  return(c)
}
