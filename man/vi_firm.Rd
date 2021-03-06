% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vi_firm.R
\name{vi_firm}
\alias{vi_firm}
\alias{vi_firm.default}
\title{Variance-based variable importance}
\usage{
vi_firm(object, ...)

\method{vi_firm}{default}(object, feature_names, FUN = NULL, var_fun = NULL, ice = FALSE, ...)
}
\arguments{
\item{object}{A fitted model object (e.g., a \code{"randomForest"} object).}

\item{...}{Additional optional arguments to be passed on to
\code{\link[pdp]{partial}}.}

\item{feature_names}{Character string giving the names of the predictor
variables (i.e., features) of interest.}

\item{FUN}{Deprecated. Use \code{var_fun} instead.}

\item{var_fun}{List with two components, \code{"cat"} and \code{"con"},
containing the functions to use to quantify the variability of the feature
effects (e.g., partial dependence values) for categorical and continuous
features, respectively. If \code{NULL}, the standard deviation is used for
continuous features. For categorical features, the range statistic is used
(i.e., (max - min) / 4). Only applies when \code{method = "firm"}.}

\item{ice}{Logical indicating whether or not to estimate feature effects
using \emph{individual conditional expectation} (ICE) curves.
Only applies when \code{method = "firm"}. Default is \code{FALSE}. Setting
\code{ice = TRUE} is preferred whenever strong interaction effects are
potentially present.}
}
\value{
A tidy data frame (i.e., a \code{"tibble"} object) with two columns,
\code{Variable} and \code{Importance}, containing the variable name and its
associated importance score, respectively.
}
\description{
Compute variance-based variable importance using a simple
\emph{feature importance ranking measure} (FIRM) approach; for details, see
\href{https://arxiv.org/abs/1805.04755}{Greenwell et al. (2018)} and
\href{https://arxiv.org/abs/1904.03959}{Scholbeck et al. (2019)}.
}
\details{
This approach to computing VI scores is based on quantifying the
relative "flatness" of the effect of each feature. Feature effects can be
assessed using \emph{partial dependence plots} (PDPs) or
\emph{individual conditional expectation} (ICE) curves. These approaches are
model-agnostic and can be applied to any supervised learning algorithm. By
default, relative "flatness" is defined by computing the standard deviation
of the y-axis values for each feature effect plot for numeric features; for
categorical features, the default is to use range divided by 4. This can be
changed via the `var_fun` argument. See
\href{https://arxiv.org/abs/1805.04755}{Greenwell et al. (2018)} for details
and additional examples.
}
\references{
Greenwell, B. M., Boehmke, B. C., and McCarthy, A. J. A Simple
and Effective Model-Based Variable Importance Measure. arXiv preprint
arXiv:1805.04755 (2018).

Scholbeck, C. A. Scholbeck, and Molnar, C.,  and Heumann C., and Bischl, B.,
and Casalicchio, G. Sampling, Intervention, Prediction, Aggregation: A
Generalized Framework for Model-Agnostic Interpretations. arXiv preprint
arXiv:1904.03959 (2019).
}
