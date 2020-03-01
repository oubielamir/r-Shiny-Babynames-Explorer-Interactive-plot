library(shiny)
library(ggplot2)
library(dplyr)
library(babynames)
library(plotly)
library(DT)



ui <- fluidPage(
  
  titlePanel('Baby Names Explorer'),
  
  sidebarLayout(
    
    sidebarPanel(
      
      textInput('name', 'Enter Name')
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel('Plot', plotlyOutput('plot_names')),
        
        tabPanel('Table', DTOutput('table_names'))
        
      )
      
      
    )
  )  
  
  
)


server <- function(input, output, session) {
  
  
  
  plot <- function() {
    
    babynames %>% filter(name == input$name) 
  }
  
  output$plot_names <- renderPlotly({
    
    ggplot(plot(), aes(year, prop, color = sex)) +geom_col()
  })
  
  output$table_names <- renderDT({
    
    plot()
  })
  
  
  
  
  
}

shinyApp(ui = ui, server = server)














