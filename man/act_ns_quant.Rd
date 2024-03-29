% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/act_ns_quant.R
\name{act_ns_quant}
\alias{act_ns_quant}
\title{A creates a dataframe showing observation counts used for a mean/CI
of selected variable within a svydesign (quantitative). Best used in conjunction with Rtesunate::act_rows().
(See act_svyciprop family of functions which combines the two)}
\usage{
act_ns_quant(x, design)
}
\arguments{
\item{x}{variable of interest (in quotes)}

\item{design}{svydesign object containing the variable/value}
}
\value{
A dataframe showing counts of observations used to calculate the mean/CI
}
\description{
A creates a dataframe showing observation counts used for a mean/CI
of selected variable within a svydesign (quantitative). Best used in conjunction with Rtesunate::act_rows().
(See act_svyciprop family of functions which combines the two)
}
\examples{
using api data from survey package
data(api)
design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
act_row("cname", "Los Angeles", design)
}
