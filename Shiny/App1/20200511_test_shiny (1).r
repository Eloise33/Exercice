
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library("ggplot2")  # Visualisation des donnÃ©es
library("dplyr")  

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  tabsetPanel(
     
     tabPanel("Welcome",
             titlePanel("L'application de votre exploitation"))),
  
  
      h2("Crées par Céline et Eloïse"),
      h3("ISARA"),
  
  titlePanel(title=div(img(src="logo.png"))),
  
   
  tabsetPanel(
    tabPanel("Faisons connaissance")),
  

  textInput("name", "Entrez le nom de votre exploitation"),
  
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("taille",
                  "taille de votre exploitation",
                  min = 1,
                  max = 500,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("totalsurface"),
    )
  ),
  
  
  tabsetPanel(
    tabPanel("Entrée des données de l'exploitation")),
  
  textOutput("nomexploitation"),  
  
  numericInput("ble", "Nombre d'hectares en ble :", 25),
  numericInput("mais", "Nombre d'hectares en mais :", 25),
  numericInput("orge", "Nombre d'hectares en orge :", 25),
  numericInput("colza", "Nombre d'hectares en colza:", 25),
  
  
  tabsetPanel(
    tabPanel("Répartition de vos cultures")),
  
  
  # Show a plot of the generated distribution
  plotOutput("camembert")
)







# Define server logic required to draw a histogram
server <- function(input, output) {
 
  output$nomexploitation <- renderText({
    paste ("Bonjour", input$name, "veuillez entrer les surfaces de vos cultures en ha")
  })
  
  output$camembert <- renderPlot({
    values <- c(input$ble,input$mais,input$orge, input$colza)
    proportions <- round(values/input$taille*100)
    pie(values,col=c("#AAFFAA","#FFEE44","#FFAAAA", "#EEEEFF"),labels=c(paste("Ble",proportions[1],"%"), paste("Mais", proportions[2],"%"), paste("Orge", proportions[3],"%"), paste("Colza", proportions[4],"%")),main="Répartition des cultures",cex=1.5)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


    