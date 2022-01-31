################################################################################
# SNOWAMP DataReader
# 
# SNOWAMPDataReader.R
#
# ReadMe: 
#
# Extract raw SNOWAMP data and bring into right date format.
# Created:          2022/02/05
# Latest Revision:  2022/02/05
#
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
# Location Kyanjing
################
path_sno <- 'D:\\Work\\FieldWork\\FieldDataSorting\\SNOWAMP' # path where data files are located and final file will be saved
finOutput <- 'finalGanjaLa2021.csv'
rawFile <- 'GanjaLa.csv'            # generally includes all climate data


datRaw <- read.table(path_sno&'\\'&rawFile,header = T, sep = ",", dec = ".")

timestr <- as.POSIXct(datRaw$Date.Time.Asia.Kathmandu., format="%Y-%m-%d  %H:%M:%S",tz='UTC')

# Combine all Data
Date <- as.Date(timestr)
Time <- strftime(timestr,format="%H:%M:%S")

expData <- data.frame(matrix(ncol = 0, nrow = length(Date)))
expData$DATE <- Date
expData$TIME <- Time
expData$TA <- datRaw$Air.Temperature.deg.C.
expData$Pres <- datRaw$Barometric.Pressure.mB.
expData$Batt <- datRaw$Battery.V.
expData$CntK <- datRaw$CS725.CntKCor..
expData$CntT <- datRaw$CS725.CntTl..
expData$SWEK <- datRaw$CS725.SweK.mm.
expData$SWET <- datRaw$CS725.SweTl.mm.
expData$GT <- datRaw$Ground.temperature.deg.C.
expData$LWin <- datRaw$Longwave.Rad.In.W.m2.
expData$LWout <- datRaw$Longwave.Rad.Out.W.m2.
expData$Precip1 <- datRaw$Precipitation.mm.
expData$Precip2 <- datRaw$Precipitation.Acc.mm.
expData$Precip3 <- datRaw$Precipitation.TB.mm.
expData$RH <- datRaw$Relative.Humidity...
expData$SDQ <- datRaw$SD.Quality..
expData$SWin <- datRaw$Shortwave.Rad.In.W.m2.
expData$SWout <- datRaw$Shortwave.Rad.Out.W.m2.
expData$SD <- datRaw$Snow.Depth.m.
expData$WindDir <- datRaw$Wind.Direction.Avg.deg.
expData$WndSped <- datRaw$Wind.Speed.Avg.m.s.
expData$WndMax <- datRaw$Wind.Speed.Max.m.s.

write.csv(expData,file=path_sno&'//'&finOutput, row.names=FALSE)


finOutput <- 'finalGanjaLaLower2021.csv'
rawFile <- 'Lower.csv'            # generally includes all climate data


datRaw <- read.table(path_sno&'\\'&rawFile,header = T, sep = ",", dec = ".")

timestr <- as.POSIXct(datRaw$Date.Time.Asia.Kathmandu., format="%Y-%m-%d  %H:%M:%S",tz='UTC')

# Combine all Data
Date <- as.Date(timestr)
Time <- strftime(timestr,format="%H:%M:%S")

expData <- data.frame(matrix(ncol = 0, nrow = length(Date)))
expData$DATE <- Date
expData$TIME <- Time
expData$TA <- datRaw$Air.Temperature.deg.C.
expData$Batt <- datRaw$Battery.Voltage.V.
expData$GT <- datRaw$Ground.Temperature.deg.C.
expData$Precip1 <- datRaw$Precipitation.TB.mm.
expData$RH <- datRaw$Relative.Humidity...
expData$SD <- datRaw$Snow.Depth.m.
expData$SDQ <- datRaw$Snow.Depth.Quality..

write.csv(expData,file=path_sno&'//'&finOutput, row.names=FALSE)


finOutput <- 'finalGanjaLaUpper2021.csv'
rawFile <- 'Upper.csv'            # generally includes all climate data


datRaw <- read.table(path_sno&'\\'&rawFile,header = T, sep = ",", dec = ".")

timestr <- as.POSIXct(datRaw$Date.Time.Asia.Kathmandu., format="%Y-%m-%d  %H:%M:%S",tz='UTC')

# Combine all Data
Date <- as.Date(timestr)
Time <- strftime(timestr,format="%H:%M:%S")

expData <- data.frame(matrix(ncol = 0, nrow = length(Date)))
expData$DATE <- Date
expData$TIME <- Time
expData$TA <- datRaw$Air.Temperature.degC.
expData$Batt <- datRaw$Battery.Voltage.V.
expData$GT <- datRaw$Ground.Temperature.degC.
expData$Precip1 <- datRaw$Precipitation.TB.mm.
expData$RH <- datRaw$Relative.Humidity...
expData$SD <- datRaw$Snow.Depth.m.
expData$SDQ <- datRaw$Snow.Depth.Quality..

write.csv(expData,file=path_sno&'//'&finOutput, row.names=FALSE)


