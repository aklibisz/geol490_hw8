####
# Adam Klibisz Geol 490 HW8
####

# Shiny app viewer of the R dataset "mtcars"

# necessary libraries
library(shiny)
library(tidyverse)

# limit the range of selectable mpg to the actual range of mpg
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
          
          #range slider 
          sliderInput("mpgrange",
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
        
        # make the action button
        actionButton("go", " ",
                     icon = icon("power-off"))
        ),

        # Show a plot 
        mainPanel(
           plotOutput("mtcars_plot")
        )
    )
)

# Define server logic required to draw the plot
server <- function(input, output) {
  
  # filter mtcars based on mpg
  filt_mtcars <- reactive({
    mtcars %>%
      filter(mpg >= min(input$mpgrange)) %>%
      filter(mpg <= max(input$mpgrange))
  })

    p_mtcars <- eventReactive(input$go, {
      ggplot(filt_mtcars(), aes_string(x = input$xvar, y = input$yvar)) + 
        geom_line()

    })
    
    #output window
    output$diagnostic <- renderText(
      input$cylrange
    )
    
    #dynamic plot plot
    output$mtcars_plot <- renderPlot(
      p_mtcars()
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)
