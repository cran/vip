# Exits
if (!requireNamespace("caret", quietly = TRUE)) {
  exit_file("Package caret missing")
}
if (!requireNamespace("Cubist", quietly = TRUE)) {
  exit_file("Package Cubist missing")
}

# # Load required packages
# suppressMessages({
#   library(caret)
#   library(Cubist)
# })

# Generate Friedman benchmark data
friedman1 <- gen_friedman(seed = 101)

# Fit model(s)
fit <- Cubist::cubist(
  x = subset(friedman1, select = -y),
  y = friedman1$y,
  committees = 10
)

# Compute VI scores
vis1 <- vi_model(fit)
vis2 <- caret::varImp(fit)

# Expectations for `vi_model()`
expect_identical(
  current = vis1$Importance,
  target = vis2[vis1$Variable, , drop = TRUE]
)

# Expectations for `get_training_data()`
expect_identical(
  current = vip:::get_training_data.cubist(fit),
  target = subset(friedman1, select = -y)
)

# Expectations for `get_feature_names()`
expect_identical(
  current = vip:::get_feature_names.cubist(fit),
  target = paste0("x", 1L:10L)
)

# Call `vip::vip()` directly
p <- vip(fit, method = "model", include_type = TRUE)

# Expect `p` to be a `"gg" "ggplot"` object
expect_identical(
  current = class(p),
  target = c("gg", "ggplot")
)

# Display VIPs side by side
grid.arrange(
  vip(vis1, include_type = TRUE),
  # vip(vis2, include_type = TRUE),
  p,
  nrow = 1
)
