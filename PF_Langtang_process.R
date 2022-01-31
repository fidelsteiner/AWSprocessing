################################################################################
# Process permafrost sensors in Langtang and aggregate to hourly data
# 
# PF_Langtang_process.R
#
# ReadMe: 
#
# The code is specific for permafrost sensors deployed in the Langtang catchment.
# 
#
# Reads in raw data to process to hourly time series.
#
# Created:          2022/01/25
# Latest Revision:  2022/01/25
#
# Jakob F Steiner| ICIMOD | jakob.steiner@icimod.org | x-hydrolab.org 
################################################################################

# clear entire workspace (excl. packages)
rm(list = ls())
gc()

# define &-sign for pasting string-elements
'&' <- function(...) UseMethod('&')
'&.default' <- .Primitive('&')
'&.character' <- function(...) paste(...,sep='')

# The TSaggregate.R code is necessary for the hourly aggregation. It is available at
# https://github.com/fidelsteiner/BasicCode/blob/master/timeseriesAnalysis/TSaggregate.R
source("D:\\Work\\Code\\BasicCode\\timeseriesAnalysis\\TSaggregate.R")

Sys.setenv(TZ='UTC')

################
# Data files
################
path_pf <- 'D:\\Work\\FieldWork\\FieldDataSorting\\permafrost\\EXPORT' # path where data files are located and final file will be saved
finOutput <- 'A521D52021.csv'
rawFile <- 'A521D5_20211123111040.csv'            # raw sensor file

datRaw <- read.table(path_pf&'\\'&rawFile,header = T, sep = ",", dec = ".")

timestr <- as.POSIXct(datRaw$No, format="%d.%m.%Y  %H:%M:%S",tz='UTC')

# aggregate raw data to hourly
T_PF_hourly <- TSaggregate(datRaw$Time,timestr,60,0,'mean')   # temperature [C]

Date <- as.Date(as.POSIXct(T_PF_hourly[,1],origin='1970-01-01 +0545'))
Time <- strftime(as.POSIXct(T_PF_hourly[,1],origin='1970-01-01'),format="%H:%M:%S")

expData <- data.frame(matrix(ncol = 0, nrow = length(Date)))
expData$DATE <- Date
expData$TIME <- Time
expData$TPF <- T_PF_hourly[,2]

write.csv(expData,file=path_pf&'//'&finOutput, row.names=FALSE)