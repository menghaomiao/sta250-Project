readRobot=function(file) {
 line=readLines(file)
 pos=grep('position2d [0-9]{2} 001', line)
 pos=pos[(pos+1) %in% grep('laser', line)]
 t=length(pos)
 robot=rep(substr(line[pos[1]], 25, 28), t) #Robot ID.
 p1=rep(line[pos], each=4) #substr() could only extract one value once.
 p2=rep(line[pos+1], each=361)
 cor=as.numeric(substr(p1, c(1, 52, 60, 68), c(14, 58, 66, 73))) #"position2d" information.
 ang=as.numeric(substr(p2, seq(93, 3340, 9), seq(97, 3340, 9))) #"laser" information.
 d1=matrix(cor, t, 4, byrow=T)
 d2=matrix(ang, t, 361, byrow=T)
 data=as.data.frame(cbind(d2, d1))
 data=data.frame(robot, data[362:365], data[1:361])
 colnames(data)[2:5]=c('time', 'xcor', 'ycor', 'yaw')
 return(data)
}
