#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("taille",
                        "taille de votre exploitation",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("camembert"),
           plotOutput("barplot")
        )
    ),
   
    numericInput("ble", "Nombre d'hectares en ble :", 1) ,
    numericInput("mais", "Nombre d'hectares en mais :", 1),
    numericInput("orge", "Nombre d'hectares en orge :", 1),
)

# Define server logic required to draw a histogram
server <- function(input, output) {
 

    
    output$camembert <- renderPlot({
      df <- data.frame(
        group = c("blé", "mais", "orge"),
        value = c(input$ble, input$mais, input$orge)
      )
      head(df)
      
    })
    
   
    # Bar plot
    output$barplot <- renderPlot({
    bp <- ggplot(df, aes(x="", y=value, fill=group))+
      geom_bar(width = 1, stat = "identity")
    bp
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
