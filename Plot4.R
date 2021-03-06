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

png("Plot4.png")

# 2 rows and 2 col with first filling column=1 then column =2
par(mfcol=c(2,2))

#Plot 1 - R1 C1
plot(y$Global_active_power ~ y$Date, type = "l", 
     ylab = "Global Active Power", 
     xlab = "", 
     main = "")

#plot 2 - R2 C1
plot(y$Sub_metering_1~y$Date, type="n", ylab = "Energy sub meterring", xlab="", main="")
points(y$Sub_metering_1~y$Date, col="black", type="l")
points(y$Sub_metering_2~y$Date, col="red", type="l")
points(y$Sub_metering_3~y$Date, col="blue", type="l")
legend("topright", col=c("black","red", "blue"), bty = "n",
       lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#plot 3 - R1 C2
plot(y$Voltage ~ y$Date, type = "l", 
     ylab = "Voltage", 
     xlab = "datetime", 
     main = "")

#plot4 - R2 C2
plot(y$Global_reactive_power ~ y$Date, type = "l", 
     ylab = "Global_reactive_power", 
     xlab = "datetime", 
     main = "")

dev.off()


