% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/act_svyciquant_tbl.R
\name{act_svyciquant_tbl}
\alias{act_svyciquant_tbl}
\title{Similar to act_svyciquant, but able to spit out a dataframe containing estimates
for multiple variables. Variables are input as vectors.}
\usage{
act_svyciquant_tbl(variable_vect_name, design_obj, ...)
}
\arguments{
\item{variable_vect_name}{a vector of variables of interest (in quotes)}

\item{...}{arguments passed to svyciquant}

\item{design}{svydesign object containing the variables/values. Can only take one svydesign.
To call multiple svydesigns in parallel, see purrr package or Rtesunate::act_svyciquant_list()}
}
\value{
A mutli-row dataframe providing the variable names, weighted means of
observations of interest, cluster-adjusted 95\% CIs, and counts of all non-NA values.
}
\description{
Similar to act_svyciquant, but able to spit out a dataframe containing estimates
for multiple variables. Variables are input as vectors.
}
\examples{
using api data from survey package
data(api)
design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
act_svyciquant_tbl(c("api00", "snum"), design)
act_svyciquant_tbl(c("api00", "snum"), design, level = 0.99)

}
