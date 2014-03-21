library(shiny)
field=paste(c(1, seq(14, by=3, len=361)), collapse=',')
shinyServer(function(input, output) {
 getData=reactive({ #Read data, similar to readRobot function.
  cmd1=paste('egrep "position2d [0-9]{2} 001"', input$file, '| cut -f1,8,9,10 -d" "')
  cmd2=paste0('egrep "laser [0-9]{2} 001" ', input$file, ' | cut -f', field, ' -d" "')
  con1=pipe(cmd1)
  d1=scan(con1)
  t1=as.data.frame(matrix(d1, length(d1)/5, 5, byrow=T))
  con2=pipe(cmd2)
  d2=scan(con2)
  t2=as.data.frame(matrix(d2, length(d2)/362, 362, byrow=T))
  close(con1, con2)
  data=merge(t1, t2, by='V1')
 })
 output$timebar=renderUI({
  data=getData()
  t=nrow(data)
  sliderInput('time', 'Time', 1, t, 1, step=1, animate=animationOptions(interval=100))
 })
 output$trial=renderPlot({ #Replay the experiment, similar to trial function.
  data=getData()
  m=as.numeric(data[n, ])
  s=seq(0, 2*pi, pi/180)+m[4]+pi
  dx=cos(s)*m[5:365]
  dy=sin(s)*m[5:365]
  x=m[2]+dx
  y=m[3]+dy
  xx=m[2]+cos(s)*2
  yy=m[3]+sin(s)*2
  par(mar=c(1, 3, 1, 3))
  plot(0, 0, type='n', xlim=c(-14.36, 14.35), ylim=c(-7.7, 7.4), xlab='', ylab='', xaxt='n', yaxt='n')
  rect(par('usr')[1], par('usr')[3], par('usr')[2], par('usr')[4], col='grey60')
  polygon(xx, yy, border='green', col='white')
  points(x, y, pch=20, cex=0.6)
  points(m[2], m[3], pch=1, col=3)
 })
})
