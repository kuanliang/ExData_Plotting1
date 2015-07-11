## read in the data to R object data frame with specified period, 2007-02-01, 2007-02-02
## Since the file is too big (188mb), rather than read in the whole file, and subseting to specified period,
## connect to the file and read line by line, check whether the first variable between the period


DF_row1 = read.table(file = "household_power_consumption.txt", sep = ";", header = T, nrow = 1)
nc <- ncol(DF_row1)

## extract classes of each varialbe for read in process
classes <- sapply(DF_row1, class)

DF.Date <- read.table(file = "household_power_consumption.txt", sep = ";", header = T, as.is = T, 
                      colClasses = c(NA, rep("NULL", nc - 1)))

skip_num <- which.max(DF.Date$Date == "1/2/2007")
temp_num <- which.max(DF.Date$Date == "3/2/2007")
row_num <- temp_num - skip_num

DF.3 <- read.table(file = "household_power_consumption.txt", sep = ";", header = T, col.names = names(DF.row1), 
                   skip = skip_num-1, nrows = row_num, colClasses = classes, na.strings = "?")

#combine the Date and Time variable to a new variable called "new_date"
DF.3 <- within(DF.3, new_date <- paste(Date, Time, sep = "/"))

par(mfrow = c(2,2), cex = 0.65)
with(DF.3, plot(strptime(new_date, "%d/%m/%Y/%H:%M:%S"), Global_active_power, type = "l",
                ylab = "Global Active Power", xlab = ""))
with(DF.3, plot(strptime(new_date, "%d/%m/%Y/%H:%M:%S"), Voltage, ylab = "Voltage", type = "l",
                xlab = "datetime"))
with(DF.3, plot(strptime(new_date, "%d/%m/%Y/%H:%M:%S"), Sub_metering_1, type = "l",
                xlab = "", ylab = "Energy sub metering"))
with(DF.3, lines(strptime(new_date, "%d/%m/%Y/%H:%M:%S"), Sub_metering_2, col = "red"))
with(DF.3, lines(strptime(new_date, "%d/%m/%Y/%H:%M:%S"), Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1), col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
                bty = "n", inset = c(0.08,0))

with(DF.3, plot(strptime(new_date, "%d/%m/%Y/%H:%M:%S"), Global_reactive_power, xlab = "datetime", type = "l"))

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()