#3. insufficient mem
memtest=data.frame(memlimit=c('18GB','10GB','6GB','2GB','1GB'),time=c(168L,160L,248L,544L,800L))
barplot(memtest$time,names.arg=memtest$memlimit,ylim=c(0,700),main="Insufficient Mem Test",xlab="Mem Limit(GB)",ylab="Time(Sec)",col="lightblue")

#1. scalability
numofnodes=c(2,3,4,5,6)
time=c(70,73.67,57,52,58.67)
barplot(time,names.arg=numofnodes,ylim=c(0,80),main="Scalability Test",xlab="Num of Nodes",ylab="Time(Sec)",col=c("lightblue"))
#2. in memory iterations
iter=c(1,2,3,4,5,6,7,8,9,10,11)
nodes12=c(62,17,11,31,23,13,10,13,15,12,20)
nodes8=c(46,11,8,6,6,8,7,10,8,9,6)
iter_time=rbind(nodes8,nodes12)
barplot(as.table(iter_time),names.arg=iter,col=c("red","lightblue"),beside=TRUE,main="Iteration Time",xlab="Num of Iteration",ylab="Time(Sec)", legend = rownames(iter_time),ylim=c(0,70))

#5. data skew
nodeindex=c(1,2,3,4)
datainmem=c(403439616,1210318843,1344798720,1492579123)
barplot(datainmem,names.arg=nodeindex,main="Data Skew",ylab="Bytes In Mem",xlab="Node Index",col=c("lightblue"))
nodeindex=c(1,2,3,4,5,6,7,8)
datainmem=c(437059584,551220019,504299520,403439616,706019328,638779392,706019328,504299520)

#*. dataset vertices, links
datasize=c('0.7G','4.2G','7.0G','9.9G')
numofver=c(42642,639973,1436185,2453307)
numofavglink=c(114.57,46.88,34.81,28.53)
barplot(numofver,names.arg=datasize,col=c("red"),main="Num of Vertices",ylim=c(0,2500000),xlab="Data size",ylab="Num of vertices")
barplot(numofavglink,names.arg=datasize,col=c("lightblue"),main="Average Num of Links",ylim=c(0,120),xlab="Data size",ylab="Average Number of links")