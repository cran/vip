# Exits
if (!requireNamespace("glmnet", quietly = TRUE)) {
  exit_file("Package glmnet missing")
}

# # Load required packages
# suppressMessages({
#   library(glmnet)
# })

# Generate Friedman benchmark data
friedman1 <- gen_friedman(seed = 101)
friedman3 <- gen_friedman(seed = 101, n_bins = 3)

# Fit model(s)
fit1 <- glmnet::glmnet(
  x = data.matrix(subset(friedman1, select = -y)),
  y = friedman1$y
)
fit2 <- glmnet::cv.glmnet(
  x = data.matrix(subset(friedman1, select = -y)),
  y = friedman1$y
)
fit3 <- glmnet::glmnet(
  x = data.matrix(subset(friedman3, select = -y)),
  y = friedman3$y,
  family = "multinomial"
)

# Compute VI scores
vis1 <- vi_model(fit1)
vis2 <- vi_model(fit2)
vis3 <- vi_model(fit3)

# Expectations for `vi_model()`
expect_identical(
  current = vis1$Importance,
  target = coef(fit1, s = min(fit1$lambda))[-1L]
)
expect_identical(
  current = vis2$Importance,
  target = coef(fit2, s = "lambda.1se")[-1L]
)
expect_identical(
  current = vis3$Importance,
  target = coef(fit3, s = min(fit3$lambda))[[1L]][-1L]
)

# # Expectations for `get_training_data()`
# expect_identical(
#   current = vip:::get_training_data.glmnet(fit),
#   target = friedman1
# )

# Expectations for `get_feature_names()`
expect_identical(
  current = vip:::get_feature_names.glmnet(fit1),
  target = paste0("x", 1L:10L)
)
expect_identical(
  current = vip:::get_feature_names.cv.glmnet(fit2),
  target = paste0("x", 1L:10L)
)
expect_identical(
  current = vip:::get_feature_names.multnet(fit3),
  target = paste0("x", 1L:10L)
)

# Call `vip::vip()` directly
p <- vip(fit1, method = "model", include_type = TRUE,
         mapping = ggplot2::aes(fill = Sign))

# Expect `p` to be a `"gg" "ggplot"` object
expect_identical(
  current = class(p),
  target = c("gg", "ggplot")
)

# Display VIPs side by side
grid.arrange(
  vip(vis1, include_type = TRUE),
  vip(vis2, include_type = TRUE),
  p,
  nrow = 1
)