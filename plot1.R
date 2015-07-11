## read in the data to R object data frame with specified period, 2007-02-01, 2007-02-02
## Since the file is too big (188mb), rather than read in the whole file, and subseting to specified period,
## connect to the file and read line by line, check whether the first variable between the period

DF_row1 = read.table(file = "household_power_consumption.txt", sep = ";", header = T, nrow = 1)
nc <- ncol(DF_row1)

## extract classes of each varialbe for read in process
classes <- sapply(DF_row1, class)

DF.Date <- read.table(file = "household_power_consumption.txt", sep = ";", header = T, as.is = T, 
            colClasses = c(NA, rep("NULL", nc - 1)))

## get the row number of the first 1/2/2007
skip_num <- which.max(DF.Date$Date == "1/2/2007")
## get the row number of the first 3/2/2007
temp_num <- which.max(DF.Date$Date == "3/2/2007")
## setting row_num as the number of lines being extracted
row_num <- temp_num - skip_num
## extract the file with skip and nrows
DF.3 <- read.table(file = "household_power_consumption.txt", sep = ";", header = T, col.names = names(DF.row1), 
            skip = skip_num-1, nrows = row_num, colClasses = classes, na.strings = "?")

## Plot the first plot "Plot 1" 
## x-axis is Global Active Power (kilowatts)
## y-axis is Frequency
## setting the layout of the lot and the font size of the plot with cex
par(mfrow = c(1,1), cex = 0.75)
hist(DF.3$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
            col = "red", main = "Global Active Power")

## copy the plot and put it into graphic device pnga
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()


