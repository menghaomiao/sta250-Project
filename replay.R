trial=function(data, n) {
 m=as.numeric(data[n, ])
 s=seq(0, 2*pi, pi/180)+m[5]+pi #Ajust according to initial angle.
 dx=cos(s)*m[6:366]
 dy=sin(s)*m[6:366]
 x=m[3]+dx
 y=m[4]+dy
 xx=m[3]+cos(s)*2
 yy=m[4]+sin(s)*2
 plot(0, 0, type='n', xlim=c(-14.36, 14.35), ylim=c(-7.74, 7.42), main='Experiment Area', xlab='x', ylab='y')
 rect(par('usr')[1], par('usr')[3], par('usr')[2], par('usr')[4], col='grey60') #Unknown area.
 polygon(xx, yy, border='green', col='white') #Area in scope.
 points(x, y, pch=20, cex=0.6) #What the robot see at each angle.
 points(m[3], m[4], pch=1, col=3) #Position of the robot.
}
