#!/usr/bin/env rscript
library(lubridate)
source('data_loader.R')

d <- load_data()

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

# First plot
plot(
    x = d$d,
    y = as.numeric(d[,"Global_active_power"]),
                xlab="",
                ylab="Global Active Power",
                col="black",
                type="l")

# Second plot
plot(
    x = d$d,
    y = as.numeric(d[,"Voltage"]),
                xlab="datetime",
                ylab="Voltage",
                col="black",
                type="l")

# Third plot
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
    lty=c(1,1,1),
    bty="n",
    cex=0.9
)

# Fourth plot
plot(
    x = d$d,
    y = as.numeric(d[,"Global_reactive_power"]),
                xlab="datetime",
                ylab="Global_reactive_power",
                col="black",
                type="l")

dev.off()