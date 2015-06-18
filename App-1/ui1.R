# ui.R

shinyUI(fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(position = "left",
    sidebarPanel(
      h1("Installation"),
      p("Shiny is available on CRAN, so you can install it
        in the usual way from your R console:"),
      code("install.packages('Shiny')"),
      br(),
      br(),
      br(),
      br(),
      img(src="bigorb.png", height = 100, width = 100),
      "shiny is a product of",
      span("RStudio", style = "color:blue")
),
    mainPanel(
      h1("Introducing Shiny"),
      p("Shiny is a new package from RStudio that makes it", 
        span("incredibly easy", style = "font-style:italic"),
        "to build interactive web applications with R."),
      p("For an introduction and live examples, visit the",
        a("Shiny homepage.",
          href = "http://www.rstudio.com/shiny")),
      br(),
      h1("Features"),
      tags$ul(
        tags$li("Build useful web applications with only a 
                few lines of code--no JavaScript required."), 
        tags$li("Shiny applications are automatically 'live'
                in the same way that",
                span("spreadsheets", style = "font-style:bold"),
                "are live. Outputs change instantly as users modify
                inputs, without requiring a reload of the browser.")
      )
    )
  )
))