#!/usr/bin/env Rscript

##########################
# Libraries
##########################

## Rethinking

library(rethinking)
library(coda)
library(mvtnorm)
library(devtools)
library(loo)
library(dagitty)
library(magick)
library(tidyverse)
library(MASS)
library(tufte)
library(gtools)
library(DT)

## With `brms` and `tidyverse`

brms_packages <- c("ape", "bayesplot", "brms", "broom", "flextable", "GGally", "ggdag", "ggdark", "ggmcmc", "ggrepel", "ggthemes", "ggtree", "ghibli", "gtools", "patchwork", "psych", "rcartocolor", "Rcpp", "remotes", "rstan", "StanHeaders", "statebins", "tidybayes", "viridis", "viridisLite", "wesanderson")
lapply(brms_packages, require, character.only = T)

##########################
# Parameters
##########################

options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

set_ulam_cmdstan(TRUE)

