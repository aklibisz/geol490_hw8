####
# Adam Klibisz Geol 490 HW8
####

# some stuff to run before anything else
library(shiny)
library(tidyverse)

# limit the range of selectable MPG to the actual range of MPG
min.mpg <- min(mtcars$mpg)
max.mpg <- max(mtcars$mpg)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Mtcars Viewer"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("mpgRange",
                        "Range of MPG",
                        min = min.mpg,
                        max = max.mpg,
                        value = c(min.mpg, max.mpg)),
    
        actionButton("go", 
                     "Go!",
                     icon = icon("thumbs-up"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {


    }

# Run the application 
shinyApp(ui = ui, server = server)
