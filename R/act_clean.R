#' act_clean
#'
#' @param db Database to clean
#' @param indiv_num Vector of variables in format of c("x", "y", etc) to retain as numeric if all whole numbers
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
    dplyr::mutate(dplyr::across(.cols = tidyselect::everything(), ~dplyr::na_if(.x,""))) %>%
    purrr::discard(~all(is.na(.))) %>%
    dplyr::mutate(dplyr::across(where(is_all_numeric), as.numeric)) %>%
    dplyr::mutate(dplyr::across(where(is_all_whole) & !tidyselect::all_of(indiv_num),
                                as.factor))

  return(a)
}
