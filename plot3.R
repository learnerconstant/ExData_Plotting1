#!/usr/bin/env rscript
library(lubridate)
source('data_loader.R')

d <- load_data()

png("plot3.png", width = 480, height = 480)
plot(
    x = d$d,
    y = as.numeric(d[,"Sub_metering_1"]),
                xlab="",
                ylab="Energy sub metering",
                col="black",
                type="l")
lines(
    x = d$d,
    y = as.numeric(d[,"Sub_metering_2"]),
                col="red")

lines(
    x = d$d,
    y = as.numeric(d[,"Sub_metering_3"]),
                col="blue")

legend(
    "topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col=c("black", "red", "blue"),
    lty=c(1,1,1)
)

dev.off()