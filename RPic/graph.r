library(methods)
library(ggplot2)
library(reshape2)

# example input file:
#    NODES,WORKERS,TIME
#    1,1,111.34
#    1,1,121.47
#    1,2,131.66
#    1,2,121.36
#    1,6,135.80
#    1,6,145.08
#    1,12,144.85
#    1,12,134.85

# makes graph and writes to file
# rawData: trial runtimes
# yLabel: label for y-axis
# outFile: output file for graph image
makeGraph <- function(rawData, yLabel, outFile)
{
    # image dim in inches
    width=6
    height=4

    # compute average, group by nodes+workers
    avgData <- tapply(rawData, list(nodes, workers), mean)

    # add node count column
    avgData <- cbind(c(1, 2, 3, 4, 5), avgData)
    avgData <- data.frame(avgData)

    # add column headers
    colnames(avgData) <- c("NODES", "1", "2", "3", "6", "12")
    avgData <- melt(avgData, id=1)
    colnames(avgData) <- c("NODES", "WORKERS", "YAXIS")

    # create graph
    timeGraph <- ggplot(avgData, aes(x=NODES, y=YAXIS, color=WORKERS)) +
                 geom_line(size=1.5) +
                 ylab(yLabel)

    # save image to paper directory
    ggsave(outFile, w=width, h=height)
}

# unix grep serial runtime (sec)
serialTime <- 1120

# uncached runtime padding
timePad = 100

# read in raw csv data
testData <- read.csv("runtime-list", header=TRUE)

# get data columns
nodes <- testData[, "NODES"]
workers <- testData[, "WORKERS"]
time <- testData[, "TIME"] + timePad

# compute metrics
processes <- 12 * nodes
speedup <- serialTime / time
efficiency <- speedup / processes
karpFlatt <- (1 / speedup - 1 / processes) / (1 - 1 / processes)

# create graphs
makeGraph(time, "TIME (s)", "runtime.png")
makeGraph(speedup, "SPEEDUP", "speedup.png")
makeGraph(efficiency, "EFFICIENCY", "efficiency.png")
makeGraph(karpFlatt, "KARP-FLATT", "karp_flatt.png")
