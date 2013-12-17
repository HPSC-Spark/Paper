library(methods)
library(ggplot2)
library(reshape2)

# example input file:
#    NODES,TIME
#    50,555.02
#    50,544.99
#    40,516.40
#    40,511.94
#    30,515.93
#    30,525.12

# file dim in inches
width=6
height=4

# read in raw csv data
testData <- read.csv("big", header=TRUE)

# get data columns
nodes <- testData[, "NODES"]
time <- testData[, "TIME"]

# compute average runtimes
meanTimes <- tapply(time, nodes, mean)

# add node count column
meanTimes <- cbind(c(5, 10, 20, 30, 40, 50), meanTimes)
meanTimes <- data.frame(meanTimes)

# get column headers
colnames(meanTimes) <- c("NODES", "TIME")

# create graph
timeGraph <- ggplot(meanTimes, aes(x=NODES, y=TIME)) +
             geom_line(size=1.5) +
             ylab("TIME (s)") +
             scale_y_continuous(limits=c(0, 800))

# write graph to file
ggsave("big-runtimes.png", w=width, h=height)
