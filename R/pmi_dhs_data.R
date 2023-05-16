#' DHS/MIS malaria data for PMI countries
#'
#' Data from DHS/MIS performed in PMI partner countries. Updated 16 May, 2023
#'
#' @docType data
#'
#' @usage data(pmi_dhs_data)
#'
#' @format A data frame with 4462 rows and 13 columns:
#' \describe{
#'   \item{CountryName}{Country name}
#'   \item{SurveyYearLabel}{Year(s) survey was conducted}
#'   \item{SurveyType}{Type of survey (e.g., DHS, MIS)}
#'   \item{Indicator}{Description of indicator as listed}
#'   \item{CharacteristicCategory}{Variable by which population was subset}
#'   \item{CharacteristicLabel}{Subset of population}
#'   \item{Value}{Value}
#'   \item{CILow}{Lower value of 95% confidence interval}
#'   \item{CIHigh}{Higher value of 95% confidence interval}
#'   \item{SurveyId}{DHS code for survey}
#'   \item{SurveyYear}{Official DHS survey year}
#'   \item{DHS_CountryCode}{Official two letter DHS country code}
#'   \item{IndicatorId}{Official indicator ID}
#'
#' @examples
#' data <- pmi_dhs_data
#'
#' @keywords datasets
#'
#' @source \href{https://dhsprogram.com/}{DHS Program}
#' @source \href{https://cran.r-project.org/web/packages/rdhs/index.html}{rdhs package}
#'

"pmi_dhs_data"
