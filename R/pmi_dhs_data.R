#' DHS/MIS malaria data for PMI countries
#'
#' Data from DHS/MIS performed in PMI partner countries
#'
#' @docType data
#'
#' @usage data(pmi_dhs_data)
#'
#' @format A data frame with 8735 rows and 28 columns:
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
#'
#' @keywords datasets
#'
#' @references USAID DHS Program
#' @references rdhs package
#'
#' @source \href{https://dhsprogram.com/}{DHS Program}
#'

"pmi_dhs_data"
