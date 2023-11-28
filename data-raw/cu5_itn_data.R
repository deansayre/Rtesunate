library(rdhs)
library(tidyverse)

itn_0_5 <- dhs_data(countryIds = list("AO",
                                      "BJ",
                                      "BF",
                                      "BU",
                                      "KH",
                                      "CM",
                                      "CD",
                                      "CI",
                                      "ET",
                                      "GM",
                                      "GN",
                                      "GH",
                                      "KE",
                                      "LA",
                                      "LB",
                                      "MD",
                                      "MW",
                                      "ML",
                                      "MZ",
                                      "MM",
                                      "NI",
                                      "NG",
                                      "RW",
                                      "SN",
                                      "SL",
                                      "TZ",
                                      "TG",
                                      "UG",
                                      "ZM",
                                      "ZW"),
                    indicatorIds = "ML_NETC_C_ITN")

itn_0_5_a <- itn_0_5 %>%
  select(Country = CountryName,
           SurveyYearLabel,
           SurveyType,
           Indicator,
           Value) %>%
  mutate(`Data Source` = paste(SurveyType, SurveyYearLabel),
         `Download Source` = "DHS") %>%
  select(-c(SurveyYearLabel,
                     SurveyType))

unicef_itn_0_5 <- rio::import("data-raw/unicef_itn_data_112023.xlsx") %>%
  janitor::remove_empty("cols") %>%
  mutate(Country = dplyr::case_match(`Geographic area`,
             "Côte d'Ivoire" ~ "Cote d'Ivoire",
             "Democratic Republic of the Congo" ~ "Congo Democratic Republic",
             "United Republic of Tanzania" ~ "Tanzania",
             .default = `Geographic area`)) %>%
  dplyr::filter(Sex == "Total") %>%
  dplyr::filter(Country %in% itn_0_5_a$Country) %>%
  dplyr::select(Country, Indicator, Value = OBS_VALUE, `Data Source` = DATA_SOURCE) %>%
  dplyr:: mutate(`Data Source` = stringr::str_replace_all(`Data Source`,
                                                          c("Demographic and Health Survey" = "DHS",
                                                            "Multiple Indicator Cluster Survey" = "MICS",
                                                            "Malaria Indicator Survey" = "MIS")),
                 `Download Source` = "UNICEF") %>%
  dplyr::mutate(Indicator = case_match(Indicator,
                                              "ITN use by children - percentage of children (under age 5) who slept under an insecticide-treated mosquito net the night prior to the survey" ~ "Children under 5 who slept under an insecticide-treated net (ITN)",
                                              .default = Indicator),
                Value = as.numeric(Value))

cu5_itn <- dplyr::bind_rows(itn_0_5_a, unicef_itn_0_5) %>%
  mutate(start = stringr::str_extract(`Data Source`, "\\d{4}")) %>%
  tibble::add_row(Country = "Zambia",
                  Indicator = "Children under 5 who slept under an insecticide-treated net (ITN)",
                  Value = 46.0,
                  `Data Source` = "MIS 2021",
                  start = "2021",
                  `Download Source` = NA) %>%
  dplyr::arrange(Country, start, `Download Source`) %>%
  mutate(`PMI Active 23` = ifelse(Country %in% c("Togo", "Gambia", "Burundi"), "No",
                                "Yes"),
         Continent = ifelse(Country %in% c("Cambodia", "Myanmar", "Thailand"), "Asia",
                         "Africa")) %>%
  dplyr::distinct(Country, Value, start, .keep_all = TRUE)



usethis::use_data(cu5_itn, overwrite = TRUE)
