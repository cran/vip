
# vip: Variable Importance Plots <img src="man/figures/logo-vip.png" align="right" width="130" height="150" />

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vip)](https://cran.r-project.org/package=vip)
[![Travis-CI Build
Status](https://travis-ci.org/koalaverse/vip.svg?branch=master)](https://travis-ci.org/koalaverse/vip)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/koalaverse/vip?branch=master&svg=true)](https://ci.appveyor.com/project/koalaverse/vip)
[![Coverage
Status](https://img.shields.io/codecov/c/github/koalaverse/vip/master.svg)](https://codecov.io/github/koalaverse/vip?branch=master)
[![CRAN RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/vip)](http://www.r-pkg.org/pkg/vip)
[![Total
Downloads](http://cranlogs.r-pkg.org/badges/grand-total/vip)](http://www.r-pkg.org/badges/grand-total/vip)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

## Overview

`vip` is an R package for constructing **v**ariable **i**mportance
**p**lots (VIPs). VIPs are part of a larger framework referred to as
*interpretable machine learning* (IML), which includes (but not limited
to): partial dependence plots (PDPs) and individual conditional
expectation (ICE) curves. While PDPs and ICE curves (available in the R
package [pdp](https://cran.r-project.org/package=pdp)) help visualize
feature effects, VIPs help visualize feature impact (either locally or
globally). An in-progress, but comprehensive, overview of IML can be
found here: <https://github.com/christophM/interpretable-ml-book>.

## Installation

``` r
# The easiest way to get vip is to install it from CRAN:
install.packages("vip")

# Alternatively, you can install the development version from GitHub:
if (!requireNamespace("devtools")) {
  install.packages("devtools")
}
devtools::install_github("koalaverse/vip")
```

For details and example usage, visit the [**vip** package
website](https://koalaverse.github.io/vip/index.html).
