% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_feature_names.R
\name{get_formula}
\alias{get_formula}
\title{Extract model formula}
\usage{
get_formula(object)
}
\arguments{
\item{object}{An appropriate fitted model object.}
}
\value{
Either a \code{\link[stats]{formula}} object or \code{NULL}.
}
\description{
Calls \code{\link[stats]{formula}} to extract the formulae from various
modeling objects, but returns \code{NULL} instead of an error for objects
that do not contain a formula component.
}
