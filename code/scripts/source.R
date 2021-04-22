#!/usr/bin/env Rscript

##########################
# Libraries
##########################

library(rethinking)
library(coda)
library(mvtnorm)
library(devtools)
library(loo)
library(dagitty)
library(magick)
library(tidyverse)

##########################
# Parameters
##########################

options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

set_ulam_cmdstan(TRUE)
