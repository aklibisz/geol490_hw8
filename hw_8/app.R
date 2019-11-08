####
# Adam Klibisz Geol 490 HW8
####

# necessary libraries
library(shiny)
library(tidyverse)

# limit the range of selectable MPG to the actual range of MPG
min.mpg <- min(mtcars$mpg)
max.mpg <- max(mtcars$mpg)

# vector of axis variables as characters
axis_vars <- names(mtcars)


# Define UI 
ui <- fluidPage(

    # title
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
           plotOutput("mtcars_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # filter mtcars based on mpg
  filt_mtcars <- reactive({
    mtcars %>%
      filter(mpg >= min(input$mpgrange)) %>%
      filter(mpg <= max(input$mpgrange))
  })

    p_mtcars <- eventReactive(input$go, {
      ggplot(filt_mtcars(), aes_string(x = input$xvar, y = input$yvar, colour = input$color)) + # Note that you need () after filt_dia, since filt_dia() is a function to get the object you want, not the actual object
        geom_point()

    })
    
    #output window
    output$diagnostic <- renderText(
      input$mpgrange
    )
    
    #dynamic plot plot
    output$mtcars_plot <- renderPlot(
      p_mtcars()
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)
