## code to prepare `pmi_dhs_data` dataset goes here
library(rdhs)
library(tidyverse)

indicators <- dhs_indicators()

ind1 <- indicators %>%
  filter(str_detect(Definition, "alaria") | str_detect(Definition, "fever") |
           str_detect(Definition, "Fever"))

data1 <- dhs_data(countryIds = list("AO",
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
                  tagIds = "36", breakdown = "all")
pmi_dhs_data <- data1 %>%
  select(-c(DataId, IsPreferred, SDRID, Precision, RegionId, IndicatorOrder,
            CharacteristicId, IsTotal, ByVariableLabel,
            LevelRank, DenominatorWeighted, DenominatorUnweighted,
            CharacteristicOrder, IsTotal, LevelRank, ByVariableId)) %>%
  relocate(CountryName,
           SurveyYearLabel,
           SurveyType,
           Indicator,
           CharacteristicCategory,
           CharacteristicLabel,
           Value,
           CILow,
           CIHigh) %>%
  filter(IndicatorType == "I") %>%
  select(-IndicatorType)


usethis::use_data(pmi_dhs_data, overwrite = TRUE)
