library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- readr::read_csv("data/UC_admit.csv")

ui <- dashboardPage(
  dashboardHeader(title = "University of California"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          selectInput("x", "Select Year", choices = c("2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019"),
                      selected = "2010"),
          selectInput("y", "Select Campus", choices = c("Davis", "Berkeley", "Irvine", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz"),
                      selected = "Davis"),
          selectInput("z", "Select Category", choices = c("Applicants", "Admits", "Enrollees"),
                      selected = "Applicants")
      ), 
      box(title = "Admissions by Ethnicity", width = 6,
          plotOutput("plot", width = "600px", height = "500px")
      ) 
    ) 
  ) 
)

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(Academic_Yr==input$x & Campus==input$y & Category==input$z) %>% 
      ggplot(aes(x=Ethnicity, y=FilteredCountFR)) + 
      geom_col(color="black", fill="gold", alpha=0.8) +
      theme_light(base_size = 19) +
      coord_flip()+
      labs(x = "Ethnicity", y = "# of Individuals")
  })
  
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)
