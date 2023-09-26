#' Creates crosstabs showing weighted proportion and CIs for two categorical
#' variables of interest
#'
#' @param x variable of interest in svydesign object
#' @param y variable of interest in svydesign object
#' @param design svydesign object
#' @param hundo string variable indicating how estimates add to 100%. Current
#' options are "diagonal" or "row" (the default)
#' @param print Boolean variable; determines if output is tidy/friendly for
#' additional manipulation or in 2x2 format for print/human reading. Defaults to
#' FALSE
#'
#' @return Crosstab of weighted proportions/CIs for two categorical variables
#'
#' @examples
#' library(survey)
#' data(api)
#' dclus1 <- svydesign(id=~dnum, weights=~pw, data=apiclus1, fpc=~fpc)
#'
#' act_xtab("sch.wide", "comp.imp", dclus1, print = TRUE, method = "li")

#' @export
act_xtab <- function(x, y, design,
                     hundo = "row",
                     print = FALSE, ...){
  x1 <- rlang::sym(x)
  y1 <- rlang::sym(y)

  #get dataframe
  df <- Rtesunate::act_extract_svydesign(design)

  # get all combinations of variables desired
  list_fin <- list()
  if (hundo == "diagonal"){

  combo <- tidyr::expand_grid(a = unique(eval(x1, envir = df)),
                              b = unique(eval(y1, envir = df))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.factor), as.character))

  list1 <- purrr::flatten(list(combo$a))
  list2 <- purrr::flatten(list(combo$b))

  for (i in 1:length(list1)){
    list1a <- rlang::sym(list1[[i]])
    list2a <- rlang::sym(list2[[i]])
    form <- paste0("~I(",x,"==", "'",list1a, "' & ",
                   y, "== '", list2a, "')")
    c <- try(svyciprop(as.formula(form), design = design, ...,
                             na.rm=TRUE))
    if (inherits(c, "try-error")) {
      m <- tibble::tribble(~var1, ~var2,  ~prop,  ~`2.5%`,  ~`97.5%`,
                           list1[[i]],  list2[[i]],  NA_real_, NA_real_,NA_real_)}
    else{
      k <- svyciprop(as.formula(form), design = design, ...,
                na.rm=TRUE)
      l <- attr(k, "ci") %>%
        as.data.frame()%>%
        tibble::rownames_to_column() %>%
        tidyr::pivot_wider(names_from = rowname, values_from = 2)

      m <- k %>%
        as.vector() %>%
        as.data.frame() %>%
        dplyr::rename(prop = 1) %>%
        dplyr::bind_cols(l) %>%
        dplyr::mutate(var1 = list1[[i]],
                      var2 = list2[[i]]) %>%
        dplyr::relocate(var1, var2)
    }
    list_fin[[i]] <- m}} else if (hundo == "row"){
      combo <- tibble(a = unique(eval(x1, envir = df))) %>%
        dplyr::mutate(dplyr::across(dplyr::where(is.factor), as.character))

      combo1 <- tibble(b = unique(eval(y1, envir = df))) %>%
        dplyr::mutate(dplyr::across(dplyr::where(is.factor), as.character))


      list1 <- purrr::flatten(list(combo$a))
      list2 <- purrr::flatten(list(combo1$b))


      design_list <- list()
      for (i in 1:length(list1)){

      list1a <- rlang::sym(list1[[i]])

      design_list[[i]] <- subset(design,
                                 eval(parse(text = paste0(x1,"==", "'",
                                                          list1a, "'" ))))

      var_list <- list()


      for (e in 1:length(list2)){

        list2a <- rlang::sym(list2[[e]])

        form <- paste0("~I(",y, "== '", list2a, "')")


      c <- try(svyciprop(as.formula(form), design = design_list[[i]], ...,
                         na.rm=TRUE))
      if (inherits(c, "try-error")) {
        m <- tibble::tribble(~var1,        ~var2,       ~prop,  ~`2.5%`,  ~`97.5%`,
                             list1[[i]],  list2[[e]],  NA_real_, NA_real_,NA_real_)}
      else{
        k <- svyciprop(as.formula(form), design = design_list[[i]], ...,
                       na.rm=TRUE)
        l <- attr(k, "ci") %>%
          as.data.frame()%>%
          tibble::rownames_to_column() %>%
          tidyr::pivot_wider(names_from = rowname, values_from = 2)

        m <- k %>%
          as.vector() %>%
          as.data.frame() %>%
          dplyr::rename(prop = 1) %>%
          dplyr::bind_cols(l) %>%
          dplyr::mutate(#var1 = list1[[i]],
                        var2 = list2[[e]]) %>%
          dplyr::relocate(var2)
      }
      var_list[[e]] <- m
      }

        list_fin[[i]] <- var_list %>%
      purrr::list_rbind()
      }
      list_fin <- purrr::set_names(list_fin, list1)
    }
#  return(list_fin)
#}
#      list_fin[[i]][[e]] <- l
#      list_fin <- purrr::list_flatten(list_fin)
#      }
#    }}

    list_out <- purrr::list_rbind(list_fin, names_to = "var1") %>%
    rename(!!x1 := var1,
           !!y1 := var2)

  if (print == TRUE){
    list_out1 <- list_out %>%
      dplyr::mutate(dplyr::across(dplyr::where(is.numeric),
                                  ~round(100*.x, 1))) %>%
      dplyr::mutate(char = paste0(prop, " (", `2.5%`, "-", `97.5%`, "%)")) %>%
      dplyr::select(1,2, char) %>%
      tidyr::pivot_wider(names_from = 2, values_from = char)
    return(list_out1)
  } else{
  return(list_out)
}
}
