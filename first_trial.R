library(parallel)
source('new_method.R')
source('replay.R')
files=list.files()
cl=makeCluster(32, 'FORK')
alldata=clusterApplyLB(cl, files, readRobot)
stopCluster(cl)
sapply(1:nrow(alldata[[1]]), function(i) trial(alldata[[1]], i)) #Create an animation.
