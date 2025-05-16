library(shiny)
library(ggplot2)
library(readr)

# Load your data
ag_data <- read_csv("ag_prices_named_final.csv")

# UI
ui <- fluidPage(
  titlePanel("Agricultural Prices by Year"),
  sidebarLayout(
    sidebarPanel(
      selectInput("item", "Select Item:", choices = names(ag_data)[-1])
    ),
    mainPanel(
      plotOutput("price_plot")
    )
  )
)

# Server
server <- function(input, output) {
  output$price_plot <- renderPlot({
    ggplot(ag_data, aes_string(x = "Year", y = input$item)) +
      geom_line(color = "darkblue", size = 1) +
      labs(
        title = paste("Average Price of", input$item),
        x = "Year",
        y = "Price (USD)"
      ) +
      theme_minimal()
  })
}

# Run the app
shinyApp(ui = ui, server = server)
