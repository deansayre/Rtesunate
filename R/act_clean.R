#' @title act_clean
#' @description Uses linelist::clean_data to clean strings and subsequently works
#' to back convert inappropriately modified numeric and factor data to correct classes
#'
#' @param db Database to clean
#' @param indiv_num Vector of variables in format of c("x", "y", etc) to retain
#' as numeric if all whole numbers (which are otherwise converted to factors)
#'
#' @return A hopefully cleaner database
#' @export
#'
#' @examples
#' act_clean(db)

act_clean <- function(db, indiv_num = NULL){
  a <- db %>%
    linelist::clean_data(guess_dates = F) %>%
    dplyr::mutate(dplyr::across(.cols = tidyselect::everything(), ~act_one_under(.x))) %>%
    dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(.x,""))) %>%
    purrr::discard(~all(is.na(.))) %>%
    dplyr::mutate(dplyr::across(where(is_all_numeric), as.numeric)) %>%
    dplyr::mutate(dplyr::across(where(is_all_whole) & !tidyselect::all_of(indiv_num),
                                as.factor))

  return(a)
}
