library(dplyr)
library(lubridate)
#
# Read and clean the data. Date and Time are read as characters rest of columns as numeric
# Convrt to tibble and date/time to lubridate 
# filter only 1st feb and 2nd feb of 2007; kill all na rows


y<- read.table( file = "household_power_consumption.txt",header = TRUE, sep = ";", 
                colClasses = c(rep("character",2), rep("numeric", 7)), 
                na.strings = "?", stringsAsFactors = FALSE) %>% 
    as_tibble() %>% 
    mutate(Date = dmy_hms(paste(Date, Time))) %>% 
    filter(Date >= dmy("01022007") & Date < dmy("03022007")) %>%
    select( -Time) %>%
    na.omit()

png("Plot1.png")
hist(y$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()


