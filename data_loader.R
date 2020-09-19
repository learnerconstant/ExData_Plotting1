#!/usr/bin/env rscript
library(lubridate)

# Constants
dataset_name <- "household_power_consumption.txt"
subset_dataset_name <- "household_power_consumption_subset.txt"

# Helper functions
load_data_and_create_subset <- function(){
    #' Load full dataset from the disk and create a subset so that
    #' we can skip loading the full dataset again.
    d <- read.table(dataset_name, sep=";", header=TRUE)
    # Remove observation with missing values.  Missing values are indicated by ? or empty
    # for sub_metering_3
    num_records <- nrow(d)
    d <- 
        d[
            d["Global_active_power"] != "?" &
            d["Global_active_power"] != "" &
            d["Global_reactive_power"] != "?" &
            d["Global_reactive_power"] != "" &
            d["Voltage"] != "?" &
            d["Voltage"] != "" &
            d["Global_intensity"] != "?" &
            d["Global_intensity"] != "" &
            d["Sub_metering_1"] != "?" &
            d["Sub_metering_1"] != "" &
            d["Sub_metering_2"] != "?" &
            d["Sub_metering_2"] != "" &
            d["Sub_metering_3"] != "?" &
            d["Sub_metering_3"] != ""
              ,]
    print(sprintf("Filtered out %d observations containing missing values", num_records - nrow(d)))
    d$d <- dmy_hms(paste(d$Date, d$Time))
    d_sub <- d[d$d >= ymd_hms("2007-02-01 0:00:00") & d$d < ymd_hms("2007-02-03 0:00:00"),]
    d_sub2 <- subset(d_sub, select=-c(d))  # Drop the newly added datetime column for writing
    write.table(d_sub2, file=subset_dataset_name, sep=";", col.names=TRUE)
    d_sub
}

load_subset_dataset <- function(){
    #' Load subset from the disk
    d <- read.table(subset_dataset_name, sep=";", header=TRUE)
    d$d <- dmy_hms(paste(d$Date, d$Time))
    d
}

load_data <- function(){
    #' Return observations
    #' Returns the preprocessed subset if it already exists
    if(file.exists(subset_dataset_name) == FALSE){
        print(sprintf("%s does not exist.  Reading the full dataset.", subset_dataset_name)) 
        d <- load_data_and_create_subset()   
    } else{
        print(sprintf("%s found.  Loading ...", subset_dataset_name)) 
        d <- load_subset_dataset()   
    }
    d
}