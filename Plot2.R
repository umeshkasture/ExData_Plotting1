library(dplyr)
library(lubridate)


y<- read.table( file = "household_power_consumption.txt",header = TRUE, sep = ";",
                colClasses = c(rep("character",2), rep("numeric", 7)),
                na.strings = "?", stringsAsFactors = FALSE) %>%
    as_tibble() %>%
    mutate(Date = dmy_hms(paste(Date, Time))) %>%
    filter(Date >= dmy("01022007") & Date < dmy("03022007")) %>%
    select( -Time) %>%
    na.omit()
png("Plot2.png")
plot(y$Global_active_power ~ y$Date, type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "", 
     main = "")
dev.off()


