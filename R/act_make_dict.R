#' @title act_make_dict
#' @description Creates a dataframe and optionally Excel file that can be
#' subsequently used as a dictionary in matchmaker or linelist for assignment of
#'  uniform spellings across multiple dataframes
#'
#' @param vec1 Vector designated as correctly spelled (e.g., health facility
#' names in dataframe 1) to which all others will be changed for the purposes of
#' matching
#' @param list1 Either a vector or list of vectors that will be used for matching
#' multiple datasets (e.g., health facility names in dataframes 2, 3, and 4)
#' @param excel Whether or not to write to Excel, accepts TRUE (default) or FALSE
#' @param filename Name to be used for Excel dictionary file, if Excel = TRUE
#' (default is "dictionary.xlsx"; must be written in quotes)
#'
#' @return A database (and optionally an Excel file) showing R's guesses how to
#' change spellings to match those in the specified "good spelling" vector, vec1.
#' Some of the spelling guesses made by R will undoubtedly be incorrect and will
#' have to be edited by hand for use as a dictionary, hence the default writing
#' to Excel.
#' Variable names: (1) change_to: R's guess for the good spelling to use
#'                 (2) change_from: The "bad spelling" to change
#'                 (3) goodspell_options_unmatched: The "correctly spelled"
#'                 variables in vec1 that do not have a match in list1 or a
#'                 match suggested by the function
#'                 (4) goodspell_options_all: All of the unique entries in vec1
#' @export
#'
#' @examples
#' vec1 <- c("Frank", "Tom", "Jerry")
#' vec2 <- c("frank", "fraak", "Larry")
#' vec3 <- c("Frank", "thom", "gerry")
#' vec4 <- c("Frank", "tom", "Harry")
#' list1 <- list(vec2, vec3, vec4)
#'
#' dictionary <- act_make_dict(vec1, list1)

act_make_dict <- function(vec1, list1,
                          excel = TRUE, filename = "dictionary.xlsx",
                          method = "osa"){
  if (is.list(list1)){
    vec2 <- unique(unlist(list1))
  }
  else {vec2 <- list1}
  a <- na.omit(dplyr::setdiff(vec1, vec2))  # what's in the gold standard spelling list that went unmatched
  b <- na.omit(dplyr::setdiff(vec2, vec1))  # what's in the other names lists that doesn't match the gold standard (bad spelling)


  correction <- unlist(purrr::map(b, ~vec1[which.min(stringdist(.x, vec1,
                                                                method = method))]))  # R's guess in the gold standard for each of the "bad spellings"

  a1 <- dplyr::setdiff(a, correction)

  n <- max(length(unique(vec1)), length(b), length(correction))
  length(b) <- n
  length(correction) <- n
  length(a1) <- n
  length(unique(vec1)) <- n

  # correction1 <- unlist(map(correction, ~ifelse(is.null(.x), NA_character_, .x)))

  comp_guess <- bind_cols(correction, b) %>%
    rename(change_to = 1,
           change_from = 2) %>%
    arrange(change_from) %>%
    bind_cols(a1, sort(vec1)) %>%
    rename(goodspell_options_unmatched = 3,
           goodspell_options_all = 4)

  if (excel == TRUE){
    rio::export(comp_guess, filename)
  }
  return(comp_guess)
}
