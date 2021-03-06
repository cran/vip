% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vi_permute.R
\name{vi_permute}
\alias{vi_permute}
\alias{vi_permute.default}
\title{Permutation-based variable importance}
\usage{
vi_permute(object, ...)

\method{vi_permute}{default}(
  object,
  feature_names = NULL,
  train = NULL,
  target = NULL,
  metric = NULL,
  smaller_is_better = NULL,
  type = c("difference", "ratio"),
  nsim = 1,
  keep = TRUE,
  sample_size = NULL,
  sample_frac = NULL,
  reference_class = NULL,
  pred_fun = NULL,
  pred_wrapper = NULL,
  verbose = FALSE,
  progress = "none",
  parallel = FALSE,
  paropts = NULL,
  ...
)
}
\arguments{
\item{object}{A fitted model object (e.g., a \code{"randomForest"} object).}

\item{...}{Additional optional arguments. (Currently ignored.)}

\item{feature_names}{Character string giving the names of the predictor
variables (i.e., features) of interest. If \code{NULL} (the default) then the
internal `get_feature_names()` function will be called to try and extract
them automatically. It is good practice to always specify this argument.}

\item{train}{A matrix-like R object (e.g., a data frame or matrix)
containing the training data. If \code{NULL} (the default) then the
internal `get_training_data()` function will be called to try and extract it
automatically. It is good practice to always specify this argument.}

\item{target}{Either a character string giving the name (or position) of the
target column in \code{train} or, if \code{train} only contains feature
columns, a vector containing the target values used to train \code{object}.}

\item{metric}{Either a function or character string specifying the
performance metric to use in computing model performance (e.g., RMSE for
regression or accuracy for binary classification). If \code{metric} is a
function, then it requires two arguments, \code{actual} and \code{predicted},
and should return a single, numeric value. Ideally, this should be the same
metric that was used to train \code{object}. See \code{\link{list_metrics}}
for a list of built-in metrics.}

\item{smaller_is_better}{Logical indicating whether or not a smaller value
of \code{metric} is better. Default is \code{NULL}. Must be supplied if
\code{metric} is a user-supplied function.}

\item{type}{Character string specifying how to compare the baseline and
permuted performance metrics. Current options are \code{"difference"} (the
default) and \code{"ratio"}.}

\item{nsim}{Integer specifying the number of Monte Carlo replications to
perform. Default is 1. If \code{nsim > 1}, the results from each replication
are simply averaged together (the standard deviation will also be returned).}

\item{keep}{Logical indicating whether or not to keep the individual
permutation scores for all \code{nsim} repetitions. If \code{TRUE} (the
default) then the individual variable importance scores will be stored in an
attribute called \code{"raw_scores"}. (Only used when \code{nsim > 1}.)}

\item{sample_size}{Integer specifying the size of the random sample to use
for each Monte Carlo repetition. Default is \code{NULL} (i.e., use all of the
available training data). Cannot be specified with \code{sample_frac}. Can be
used to reduce computation time with large data sets.}

\item{sample_frac}{Proportion specifying the size of the random sample to use
for each Monte Carlo repetition. Default is \code{NULL} (i.e., use all of the
available training data). Cannot be specified with \code{sample_size}. Can be
used to reduce computation time with large data sets.}

\item{reference_class}{Character string specifying which response category
represents the "reference" class (i.e., the class for which the predicted
class probabilities correspond to). Only needed for binary classification
problems.}

\item{pred_fun}{Deprecated. Use \code{pred_wrapper} instead.}

\item{pred_wrapper}{Prediction function that requires two arguments,
\code{object} and \code{newdata}. The output of this function should be
determined by the \code{metric} being used:

\describe{
  \item{Regression}{A numeric vector of predicted outcomes.}
  \item{Binary classification}{A vector of predicted class labels (e.g., if
  using misclassification error) or a vector of predicted class probabilities
  for the reference class (e.g., if using log loss or AUC).}
  \item{Multiclass classification}{A vector of predicted class labels (e.g.,
  if using misclassification error) or a A matrix/data frame of predicted
  class probabilities for each class (e.g., if using log loss or AUC).}
}}

\item{verbose}{Logical indicating whether or not to print information during
the construction of variable importance scores. Default is \code{FALSE}.}

\item{progress}{Character string giving the name of the progress bar to use.
See \code{\link[plyr]{create_progress_bar}} for details. Default is
\code{"none"}.}

\item{parallel}{Logical indicating whether or not to run \code{vi_permute()}
in parallel (using a backend provided by the \code{foreach} package). Default
is \code{FALSE}. If \code{TRUE}, an appropriate backend must be provided by
\code{foreach}.}

\item{paropts}{List containing additional options to be passed on to
\code{foreach} when \code{parallel = TRUE}.}
}
\value{
A tidy data frame (i.e., a \code{"tibble"} object) with two columns:
\code{Variable} and \code{Importance}.
}
\description{
Compute permutation-based variable importance scores for the predictors in a
model.
}
\details{
Coming soon!
}
\examples{
\dontrun{
# Load required packages
library(ggplot2)  # for ggtitle() function
library(nnet)     # for fitting neural networks

# Simulate training data
trn <- gen_friedman(500, seed = 101)  # ?vip::gen_friedman

# Inspect data
tibble::as_tibble(trn)

# Fit PPR and NN models (hyperparameters were chosen using the caret package
# with 5 repeats of 5-fold cross-validation)
pp <- ppr(y ~ ., data = trn, nterms = 11)
set.seed(0803) # for reproducibility
nn <- nnet(y ~ ., data = trn, size = 7, decay = 0.1, linout = TRUE,
           maxit = 500)

# Plot VI scores
set.seed(2021)  # for reproducibility
p1 <- vip(pp, method = "permute", target = "y", metric = "rsquared",
          pred_wrapper = predict) + ggtitle("PPR")
p2 <- vip(nn, method = "permute", target = "y", metric = "rsquared",
          pred_wrapper = predict) + ggtitle("NN")
grid.arrange(p1, p2, ncol = 2)

# Mean absolute error
mae <- function(actual, predicted) {
  mean(abs(actual - predicted))
}

# Permutation-based VIP with user-defined MAE metric
set.seed(1101)  # for reproducibility
vip(pp, method = "permute", target = "y", metric = mae,
    smaller_is_better = TRUE,
    pred_wrapper = function(object, newdata) predict(object, newdata)
) + ggtitle("PPR")
}
}
