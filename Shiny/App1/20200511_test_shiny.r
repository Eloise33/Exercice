
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)


ui <- fluidPage(
  titlePanel("Bienvenue sur l'application de votre exploitation"), 
    
 mainPanel(
  h3("Créée par Céline Jacqueton et Eloïse Giroud"),
  h4("ISARA")
      ),
 
  img (src="<logo_isara>"),
  
  textInput("name", "Le nom de votre exploitation est:"),
  textOutput("nomexploitation"),
  numericInput("ble", "Nombre d'hectares en ble :", 20 ) ,
  numericInput("mais", "Nombre d'hectares en mais :", 20),
  numericInput("orge", "Nombre d'hectares en orge :", 20),
  
  # Show a plot of the generated distribution
  plotOutput("camembert")
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$nomexploitation <- renderText({
  paste("Bonjour", input$name, ", veuillez entrer les valeurs de surface de vos cultures ci dessous")
    })
  
  output$camembert <- renderPlot({
    valeurs <- c(input$ble,input$mais,input$orge)
    pie(valeurs,col=c("#AAFFAA","#FFEE44","#FFAAAA"),labels=c("Ble","Mais","Orge"),main="Répartition des cultures",cex=1.5)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

    
    