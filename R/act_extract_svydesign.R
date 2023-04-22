#' Extracts dataframe from svydesign. Not terribly useful on own, but called in other Rtesunate functions
#'
#' @param design_object svydesign object of interest in functions act_row, act_ns, etc
#'
#'
#' @return Dataframe used to build svydesign used
#'
#' @examples
#' using api data from survey package
#' act_extract_svydesign(apistrat)



act_extract_svydesign <- function(design_object) {

  tryCatch({
    # Extract the dataset from the svydesign object
    dataset <- design_object[["variables"]]

    # Return the dataset
    return(dataset)
  }, error = function(e) {
    # Log the error
    cat("Error: ", conditionMessage(e), "\n")
    return(NULL)
  })
}
