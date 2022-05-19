facade <- function(df, dict){
  df1 <- matchmaker::match_df(df,
                              dictionary = dict,
                              from = "code",
                              to = "def",
                              by = "new") %>%
    mutate(across(where(is.character), ~str_replace_all(.x, "_", " "))) %>%
    mutate(across(where(is.character), ~str_to_title(.x)))
  return(df1)
}

devtools::load_all()
