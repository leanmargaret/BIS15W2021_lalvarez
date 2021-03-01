library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- readr::read_csv("data/UC_admit.csv")
UC_admit$Academic_Yr <- as.factor(UC_admit$Academic_Yr)

ui <- dashboardPage(
  dashboardHeader(title = "University of California"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          selectInput("x", "Select Campus", choices = c("Davis", "Berkeley", "Irvine", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz"),
                      selected = "Davis"),
          selectInput("y", "Select Category", choices = c("Applicants", "Admits", "Enrollees"),
                      selected = "Applicants"),
          selectInput("z", "Select Ethnicity", choices = c("International", "Unknown", "White", "Asian", "Chicano/Latino", "American Indian", "African American"),
                      selected = "International")
      ), 
      box(title = "Admissions by Year", width = 6,
          plotOutput("plot", width = "600px", height = "500px")
      ) 
    ) 
  ) 
)

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(Campus==input$x & Category==input$y & Ethnicity==input$z) %>% 
      ggplot(aes(x=Academic_Yr, y=FilteredCountFR)) + 
      geom_col(color="black", fill="gold", alpha=0.8) +
      theme_light(base_size = 19) +
      labs(x = "Year", y = "# of Individuals")
  })
  
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)