library(shiny)

# Create the user interface
ui <- fluidPage(
  
  # Create title panel
  titlePanel("Probability of Falling Asleep in Class"),
  
  # Making a sidebar layout
  sidebarLayout(
    
    # Create a sidebar panel with inputs and submit button
    sidebarPanel(
      selectInput(inputId = "coffee",
                  label = "Coffee:",
                  choices = list(No = 0, Yes = 1)),
      numericInput(inputId = "hours",
                   label = "Hours of sleep:",
                   value = 0),
      numericInput(inputId = "age",
                   label = "Age:",
                   value = 0),
      selectInput(inputId = "enjoy",
                  label = "Enjoy the material",
                  choices = list(No = 0, Yes = 1)),
      actionButton(inputId = "submit",
                   label = "Submit")
    ),
    
    # Create a main panel to display probability
    mainPanel(
      verbatimTextOutput("result")
    )
    
  )
  
)

# Define the server logic
server <- function(input, output){
  
  # Load the model and get coefficients
  load("m_asleep.RData")
  b <- coefficients(m)
  
  # Create vector of user inputs when submit button is clicked
  x <- eventReactive(input$submit, {c(1, as.numeric(input$coffee), input$hours, input$age, as.numeric(input$enjoy))})
  
  # Calculate probability and store in output variable to display in mainPanel()
  output$result <- renderPrint({
    noquote(paste0(as.numeric(round((1/(1+exp(-(b%*%x()))))*100, 1)), "%"))
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)