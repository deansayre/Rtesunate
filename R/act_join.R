#' Modifier of tidyverse joins to return only unique 1-to-1 joins or a list of
#' dataframes serving for join 'diagnostics'
#'
#' @param x a dataframe to join
#' @param y another dataframe to join
#' @param type type of join to perform (in quotes). Options are "left_join" (default),
#' "inner_join", "full_join", "semi_join", and "right_join". See separate help
#' pages for these functions to determine which is most appropriate
#' @param out output desired (in quotes). "pipe" (default) returns a single dataframe
#' containing only perfect 1-to-1 matches. "list" returns a list of dataframes
#' containing all 'diagnostic' categories (1-to-1, rows in x duplicated, rows
#' in y duplicated, unmatched observations from x, unmatched observations from y)
#' @param ... passed to join function of choice
#'
#' @return Dependent on 'out' parameter. See above
#' @import dplyr
#' @import janitor
#' @import purrr
#'
#' @export
#'
#' @examples
#' test <- act_join(x, y, by = c("param1" = "param1", "param2" = "param2"))
#'
act_join <- function(x,
                     y,
                     type = "left_join",
                     out = "pipe",
                     ...){

  x1 <- x %>%
    dplyr::mutate(act_join_id_x = dplyr::row_number())

  y1 <- y %>%
    dplyr::mutate(act_join_id_y = dplyr::row_number())

  if (type == "left_join"){
    a <- dplyr::left_join(x1,y1,..., multiple = "all")
  }

  else if(type == "inner_join"){
    a <- dplyr::inner_join(x1,y1,..., multiple = "all")
  }

  else if(type == "full_join"){
    a <- dplyr::full_join(x1,y1,..., multiple = "all")
  }

  else if(type == "semi_join"){
    a <- dplyr::semi_join(x1,y1,..., multiple = "all")
  }

  else if(type == "right_join"){
    a <- dplyr::right_join(x1,y1,..., multiple = "all")
  }

  else{

    print("Please enter a valid join type in quotes. Accepted options are left_join, inner_join, full_join, semi_join, right_join")
  }

  b <- a %>%
    janitor::get_dupes(act_join_id_x)

  c <- a %>%
    janitor::get_dupes(act_join_id_y)

  a_1 <- a %>%
    dplyr::filter(!act_join_id_x %in% b$act_join_id_x) %>%
    dplyr::filter(!act_join_id_y %in% c$act_join_id_y) %>%
    dplyr::select(-c(act_join_id_x, act_join_id_y))

  d_x <- x1 %>%
    dplyr::filter(!act_join_id_x %in% a$act_join_id_x)

  d_y <- y1 %>%
    dplyr::filter(!act_join_id_y %in% a$act_join_id_y)

  out1 <- list(a_1, b, c, d_x, d_y) %>%
    purrr::set_names("one_to_one", "x_dupes", "y_dupes",
                     "x_unmatch", "y_unmatch")

  if(out == "pipe"){
    return(out1[[1]])
  }
  else{
    return(out1)
  }
}
