# Exits
if (!requireNamespace("neuralnet", quietly = TRUE)) {
  exit_file("Package 'neuralnet' missing")
}
if (!requireNamespace("NeuralNetTools", quietly = TRUE)) {
  exit_file("Package 'NeuralNetTools' missing")
}

# # Load required packages
# suppressMessages({
#   library(neuralnet)
#   library(NeuralNetTools)
# })

# Generate Friedman benchmark data
friedman1 <- gen_friedman(seed = 101)

# Fit model(s)
set.seed(101)  # for reproducibility
fit <- neuralnet::neuralnet(y ~ ., data = friedman1)

# Compute VI scores
vis1 <- vi_model(fit)
vis2 <- vi_model(fit, type = "garson")

# Expectations for `vi_model()`
expect_identical(
  current = vis1$Importance,
  target = NeuralNetTools::olden(fit, bar_plot = FALSE)$importance
)
expect_identical(
  current = vis2$Importance,
  target = NeuralNetTools::garson(fit, bar_plot = FALSE)$rel_imp
)

# Expectations for `get_feature_names()`
expect_identical(
  current = vip:::get_feature_names.nn(fit),
  target = paste0("x", 1L:10L)
)
