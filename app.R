library(shiny)

# Create UI elements
ui <- fluidPage(
  
  # Application title
  titlePanel("Probability of Falling Asleep in Class"),
  
  sidebarLayout(
    
    # Sidebar with inputs and submit button
    sidebarPanel(
      selectInput(inputId = "coffee",
                  label = "Coffee:",
                  choices = list(No=0, Yes=1)),
      numericInput(inputId = "hours",
                   label = "Hours of sleep:",
                   value = 0),
      numericInput(inputId = "age",
                   label = "Age:",
                   value = 0),
      selectInput(inputId = "enjoy",
                  label = "Enjoy the material:",
                  choices = list(No=0, Yes=1)),
      actionButton(inputId = "submit",
                   label = "Submit")
    ),
    
    # Main panel that displays probability
    mainPanel(
      verbatimTextOutput("results")
    )
  )
)

# Define server logic
server <- function(input, output){
  
  # Load model and coefficients
  load("m_asleep.RData")
  b <- coefficients(m)
  
  # Get inputs from user on click
  x <- eventReactive(input$submit,
                     {c(1, as.numeric(input$coffee), input$hours, input$age, as.numeric(input$enjoy))})
  
  # Calculate the probability and print
  output$results <- renderPrint({
    
    logodds <- b %*% x()
    prob <- 1/(1+exp(-logodds))
    percent <- round(prob, 2) * 100
    
    # Print this result
    noquote(paste0(percent, "%"))
    
  })
}

# Run the application
shinyApp(ui=ui, server=server)