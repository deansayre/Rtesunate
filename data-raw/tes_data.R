## code to prepare `tes_data` dataset goes here
pacman::p_load(rio,
               tidyverse)

data <- import("data-raw/tidyTESresults_updated2023.xlsx")

split_ci <- function(x, y){

  as.numeric(str_trim(word(x, y, sep = ",")))
  }

tes_data <-  data %>%
  mutate(across(where(is.character), ~na_if(.x, "NA"))) %>%
  janitor::remove_empty("cols") %>%
  mutate(PerProtocol_CI_D28_Uncorrected_low =
           split_ci(PerProtocol_ConfidenceIntervals_D28_Uncorrected, 1),
         PerProtocol_CI_D28_Uncorrected_high =
           split_ci(PerProtocol_ConfidenceIntervals_D28_Uncorrected, 2),
         PerProtocol_D28_CI_Corrected_low =
           split_ci(PerProtocol_D28_ConfidenceIntervals_Corrected, 1),
         PerProtocol_D28_CI_Corrected_high =
           split_ci(PerProtocol_D28_ConfidenceIntervals_Corrected, 2),
         PerProtocol_CI_D42_Uncorrected_low =
           split_ci(PerProtocol_ConfidenceIntervals_D42_Uncorrected, 1),
         PerProtocol_CI_D42_Uncorrected_high =
           split_ci(PerProtocol_ConfidenceIntervals_D42_Uncorrected, 2),
         PerProtocol_CI_D42_Ccorrected_low =
           split_ci(PerProtocol_ConfidenceIntervals_D42_Ccorrected, 1),
         PerProtocol_CI_D42_Ccorrected_high =
           split_ci(PerProtocol_ConfidenceIntervals_D42_Ccorrected, 2),
         Kaplan_Meier_d28_CI_Uncorrected_low =
           split_ci(`Kaplan-Meier day 28_ConfIntervals_Uncorrected`, 1),
         Kaplan_Meier_d28_CI_Uncorrected_high =
             split_ci(`Kaplan-Meier day 28_ConfIntervals_Uncorrected`, 2),
         Kaplan_Meier_d28_CI_corrected_low =
             split_ci(`Kaplan-Meier Day 28_ConfIntervals_corrected`, 1),
         Kaplan_Meier_d28_CI_corrected_high =
             split_ci(`Kaplan-Meier Day 28_ConfIntervals_corrected`,2)) %>%
  select(Country,
         Site,
         `Study Pop`,
         `Start Year`,
         `End Year`,
         `Year of Study Report`,
         `Arm (Antimalarial)`,
         `First Line Anitmalarial`,
         PerProtocol_D28_Uncorrected,
         PerProtocol_CI_D28_Uncorrected_low,
         PerProtocol_CI_D28_Uncorrected_high,
         PerProtocol_D28_Corrected,
         PerProtocol_D28_CI_Corrected_low,
         PerProtocol_D28_CI_Corrected_high,
         PerProtocol_D42_Uncorrected,
         PerProtocol_CI_D42_Uncorrected_low,
         PerProtocol_CI_D42_Uncorrected_high,
         PerProtocol_D42_Corrected,
         PerProtocol_CI_D42_Corrected_low = PerProtocol_CI_D42_Ccorrected_low,
         PerProtocol_CI_D42_Corrected_high = PerProtocol_CI_D42_Ccorrected_high,
         `Kaplan-Meier day 28_Uncorrected`,
         Kaplan_Meier_d28_CI_Uncorrected_low,
         Kaplan_Meier_d28_CI_Uncorrected_high,
         `Kaplan-Meier Day 28_corrected`,
         Kaplan_Meier_d28_CI_corrected_low,
         Kaplan_Meier_d28_CI_corrected_high,
         `Kaplan-Meier day 42_Uncorrected`,
         `Kaplan-Meier Day 42_corrected`,
         `Genotype markers`,
         `Raw Genotyping Available`,
         `Reinfections included in numerator of corrected efficacy` =
           `Reinfections included in numerator of corrected efficacy?`,
         `Day of efficacy results`,
         PercentACPR_Corrected,
         ConfidenceInt_Corrected,
         `MOP Funding Year`,
         Funder,
         report_link = `DOI/Link to repot`,
         Lat,
         Long)


 # sf::st_as_sf(coords = c("Long", "Lat"), crs = 4326)


usethis::use_data(tes_data, overwrite = TRUE)
