
rm(list=ls())

# Set the working directory including all files: auroc.sub.r; roc.auroc.r and the folder data.
setwd()

# --------------------------------------
# Functions
# --------------------------------------
source("roc.auroc.r")
source("auroc.sub.r")

# --------------------------------------
# Load data
# --------------------------------------

subsample.no.forecast <- 1 # 17 # Minimum number of forecasts

time.period <- seq(as.Date("2001/1/1"), as.Date("2021/6/1"), by="1 months")
time.period <- as.data.frame( time.period )

# Forecast with SVBVAR model using Baumeister and Hamilton (2019)'s World Industrial Production (WIP) index 
BKL.data <- read.table("<path until the folder data>/data/BKL.txt",sep=",",header=TRUE,na.strings="--")

# Forecast with SVBVAR model using Baumeister and Hamilton (2019)'s World Industrial Production (WIP) index plus TOSI 
GvsBKL.data <- read.table("<path until the folder data>/data/GvsBKL.txt",sep=",",header=TRUE,na.strings="--")

# Forecast with SVBVAR model using Kilian (2009)'s index (REA)
K.data <- read.table("<path until the folder data>/data/K.txt",sep=",",header=TRUE,na.strings="--")

# Forecast with SVBVAR model using Kilian (2009)'s index (REA) plus TOSI
GvsK.data <- read.table("<path until the folder data>/data/GvsK.txt",sep=",",header=TRUE,na.strings="--")

# ----------------------------------------------
# Definition of the subsample periods of Table 7
# ----------------------------------------------

# 4/2008 - 7/2009 Global financial crisis
sub.BKL.data <- BKL.data[ 88:103, ]
sub.GvsBKL.data <- GvsBKL.data[ 88:103, ]

# 7/2011 - 4/2013 Eurozone sovereign debt crisis
sub.BKL.data <- BKL.data[ 127:148, ]
sub.GvsBKL.data <- GvsBKL.data[ 127:148, ]

# 12/2019 - 6/2020 COVID-19 recession.
sub.BKL.data <- BKL.data[ 228:234, ]
sub.GvsBKL.data <- GvsBKL.data[ 228:234, ]

# Full sample
sub.BKL.data <- BKL.data
sub.GvsBKL.data <- GvsBKL.data

results.nt <- auroc.sub(sub.BKL.data)
results.wt <- auroc.sub(sub.GvsBKL.data)
