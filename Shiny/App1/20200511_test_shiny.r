
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  numericInput("ble", "Nombre d'hectares en ble :", 20 ) ,
  numericInput("mais", "Nombre d'hectares en mais :", 20),
  numericInput("orge", "Nombre d'hectares en orge :", 20),
  
  # Show a plot of the generated distribution
  plotOutput("camembert")
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$camembert <- renderPlot({
    valeurs <- c(input$ble,input$mais,input$orge)
    pie(valeurs,col=c("#AAFFAA","#FFEE44","#FFAAAA"),labels=c("Ble","Mais","Orge"),main="Répartition des cultures",cex=1.5)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

    
    