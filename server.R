server <- function(input, output) {
    poplotfin <- reactive({
        pop2 %>%
            filter(Year >= input$yearInput[1],
                   Year <= input$yearInput[2],
            )
    }) 
    
    output$poplot <- renderPlot({
        
        ggplot(poplotfin(),aes(x=Year, y=Population)) +
            geom_line() + labs(x="Year",y="Population",title="Population of Slovakia in mil.")
        
    }
    )
    output$text <- renderText({
        "You can select specific year by using the slider"
    })
    
    
    
}  


shinyApp(ui=ui, server=server)
