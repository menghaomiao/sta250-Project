readRobot=function(file) {
 field=paste(c(1, seq(14, by=3, len=361)), collapse=',')
 cmd1=paste('egrep "position2d [0-9]{2} 001"', file, '| cut -f1,3,8,9,10 -d" "')
 cmd2=paste0('egrep "laser [0-9]{2} 001" ', file, ' | cut -f', field, ' -d" "')
 con1=pipe(cmd1) #Use shell command to extract fields.
 d1=scan(con1)
 t1=as.data.frame(matrix(d1, length(d1)/5, 5, byrow=T))
 con2=pipe(cmd2)
 d2=scan(con2)
 t2=as.data.frame(matrix(d2, length(d2)/362, 362, byrow=T))
 close(con1, con2)
 data=merge(t1, t2, by='V1') #Merge data according to time.
 angles=paste0('angle', 1:361)
 colnames(data)=c('time', 'robot', 'xcor', 'ycor', 'yaw', angles)
 return(data)
}
