library(shiny)
field=paste(c(1, seq(14, by=3, len=361)), collapse=',')
shinyServer(function(input, output) {
 getData=reactive({ #Read data, similar to readRobot function.
  cmd1=paste('egrep "position2d [0-9]{2} 001"', input$file, '| cut -f1,3,8,9,10 -d" "')
  cmd2=paste0('egrep "laser [0-9]{2} 001" ', input$file, ' | cut -f', field, ' -d" "')
  con1=pipe(cmd1)
  d1=scan(con1, quiet=T)
  t1=as.data.frame(matrix(d1, length(d1)/5, 5, byrow=T))
  con2=pipe(cmd2)
  d2=scan(con2, quiet=T)
  t2=as.data.frame(matrix(d2, length(d2)/362, 362, byrow=T))
  close(con1)
  close(con2)
  data=merge(t1, t2, by='V1')
 })
 output$timebar=renderUI({
  data=getData()
  t=nrow(data)
  sliderInput('time', 'Time', 1, t, 1, step=1, animate=animationOptions(interval=100))
 })
 output$trial=renderPlot({ #Replay the experiment, similar to trial function.
  data=getData()
  if (is.null(input$time)) #Before loading data, it is null.
   return()
  par(mar=c(1, 3, 1, 3))
  m=as.numeric(data[input$time, ])
  s=seq(0, 2*pi, pi/180)+m[5]+pi
  dx=cos(s)*m[6:366]
  dy=sin(s)*m[6:366]
  x=m[3]+dx
  y=m[4]+dy
  xx=m[3]+cos(s)*2
  yy=m[4]+sin(s)*2
  plot(0, 0, type='n', xlim=c(-14.36, 14.35), ylim=c(-7.7, 7.4), xlab='', ylab='', xaxt='n', yaxt='n')
  rect(par('usr')[1], par('usr')[3], par('usr')[2], par('usr')[4], col='grey60')
  polygon(xx, yy, border='green', col='white')
  points(x, y, pch=20, cex=0.6)
  points(m[3], m[4], pch=1, col=3)
 })
})
