#!/usr/bin/env rscript
library(lubridate)
source('data_loader.R')

d <- load_data()

png("plot2.png", width = 480, height = 480)
plot(
    x = d$d,
    y = as.numeric(d[,"Global_active_power"]),
                xlab="",
                ylab="Global Active Power (kilowatts)",
                col="black",
                type="l")
dev.off()