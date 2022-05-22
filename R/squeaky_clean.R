#' squeaky_clean
#'
#' @param db Database to clean
#' @param indiv_num Vector of variables in format of c("x", "y", etc) to retain as numeric if all whole numbers
#'
#' @return A hopefully cleaner database
#' @export
#'
#' @examples
squeaky_clean <- function(db, indiv_num = NULL){
  a <- db %>%
    linelist::clean_data(guess_dates = F) %>%
    dplyr::mutate(across(.cols = everything(), ~one_underscore(.x))) %>%
    dplyr::mutate(across(.cols = everything(), ~na_if(.x,""))) %>%
    purrr::discard(~all(is.na(.))) %>%                    # removes columns with no data
    dplyr::mutate(across(where(is_all_numeric), as.numeric)) %>%  #converts all columns with 100% numeric data to numeric class
    dplyr::mutate(across(where(is_all_whole) & !all_of(indiv_num), #### this line was chnaged most recently from a working version if issues
                  as.factor))

  return(a)
}

