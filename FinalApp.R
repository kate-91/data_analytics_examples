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
    titlePanel("Vitamin C on Tooth Growth in Guinea Pigs"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("variable","Choose variable to view",
                        c("Supplement Type" = "supp", "Dose in mg"="dose")),
            
            
            checkboxInput("outliers", "Show outliers", TRUE)
        ),
        # Show a plot of the generated distribution
        mainPanel(h3(textOutput("caption")),
                  plotOutput("lenPlot")
        )
    )
)

# Define server logic required to draw a histogram
toothdata <- ToothGrowth
toothdata$supp <- factor(toothdata$sup, labels = c("Vit C","OJ"))

server <- function(input, output) {
    formulaText <- reactive({paste("len~", input$variable)})
    output$caption <- renderText({formulaText()})
    
    output$lenPlot <- renderPlot({boxplot(as.formula(formulaText()),
                                          data=toothdata,
                                          outline=input$outliers,
                                          col="#75AADB", pch=19)
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
