#
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
  
  # Application title
  titlePanel("Exploitation"),
  
  testInput("name", "Le nom de votre exploitation est:"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
        sidebarPanel(
            sliderInput("Taille",
                        "Superficie de votre exploitation:",
                        min = 0,5,
                        max = 500,
                        value = 30),
            
            
  numericInput("Mais", "Nombre d'ha de Mais:" ),
  
  numericInput("Orge", "Nombre d'ha d'Orge:"),
 
  numericInput("Ble", "Nombre d'ha de Ble:"),
       
    
        # montrer le diagramme camembert 
           plotOutput("camembert")
      )
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$camembert <- renderPlot({
        # generate Taille based on input$taille from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
