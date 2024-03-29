% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/act_svyciquant.R
\name{act_svyciquant}
\alias{act_svyciquant}
\title{A creates a one line dataframe with weighted mean, cluster-adjusted 95\% CI, and
observation counts for selected variable within a svydesign.}
\usage{
act_svyciquant(x, design, ...)
}
\arguments{
\item{x}{variable of interest (in quotes)}

\item{design}{svydesign object containing the variable/value}

\item{...}{arguments passed to stats::confint}
}
\value{
A dataframe providing the variable name, weighted mean of
a quantitative variable of interest, cluster-adjusted 95\% CI, and counts
as character variable (all non-NA values).
}
\description{
A creates a one line dataframe with weighted mean, cluster-adjusted 95\% CI, and
observation counts for selected variable within a svydesign.
}
\examples{
using api data from survey package
data(api)
design <- svydesign(id=~1,strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)
act_svyciquant("api00", design)
act_svyciquant("api00", design, level = 0.75)
}
