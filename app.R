library(shiny)
library(ggplot2)  # for the dataset

temp <- read_excel("S04AC223.xlsx")

ui <- fluidPage(
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "temp"',
        checkboxGroupInput("show_vars", "Columns to show:",
                           names(temp), selected = names(temp$VoterID && temp$VoterFirstNameEn))
      ),
      
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("temp", DT::dataTableOutput("mytable1")),
      )
    )
  )
)

server <- function(input, output) {
  
  # choose columns to display
  diamonds2 = temp[sample(nrow(temp), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(diamonds2[, input$show_vars, drop = FALSE])
  })
  
  
}

shinyApp(ui, server)

