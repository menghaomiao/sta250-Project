library(parallel)
source('new_method.R')
source('replay.R')
files=list.files()
cl=makeCluster(32, 'FORK')
alldata=clusterApplyLB(cl, files, readRobot)
stopCluster(cl)
sapply(1:nrow(alldata[[1]]), function(i) {par(mar=c(1, 1, 3, 1); trial(alldata[[1]], i)}) #Create an animation.
