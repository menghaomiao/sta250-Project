library(shiny)
files=list.files(pattern='JRSP.*\\.log')
shinyUI(pageWithSidebar(
 headerPanel('Robot Replay'),
 sidebarPanel(
  selectInput('file', 'Please choose a file:', files),
  uiOutput('timebar')
 ),
 mainPanel(h3('Experiment Area'), plotOutput('trial'))
))
