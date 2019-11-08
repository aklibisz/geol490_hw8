####
# Adam Klibisz Geol 490 HW8
####

# some stuff to run before anything else
library(shiny)
library(tidyverse)

# limit the range of selectable MPG to the actual range of MPG
min.mpg <- min(mtcars$mpg)
max.mpg <- max(mtcars$mpg)

axis_vars <- names(mtcars)
factor.indices <- vapply(mtcars, is.factor, TRUE)
factor.columns <- axis_vars[factor.indices]


# Define UI 
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
            
            # Select x and y variables
            selectInput(inputId = "xvar",
                        label = "X axis",
                        choices = axis_vars,
                        selected = "x"),
            
            selectInput(inputId = "yvar",
                        label = "Y axis",
                        choices = axis_vars,
                        selected = "y"),
    
        actionButton("go", " ",
                     icon = icon("power-off"))
        ),

        # Show a plot 
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
