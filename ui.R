library(shiny)
library(ggplot2)
library(dplyr)
library(markdown)
library(mgcv)
library(psych)
navbarPage(
    title = "Caffeine Concentration Predictor",
    ### 1 ###
    tabPanel(
        title = "PK Parameters",
        sidebarLayout(
            sidebarPanel(
                
                sliderInput(
                    inputId = "BWT",  
                    label = "Body Weight (kg)", 
                    min = 20, max = 100, value = 50, step = 1, round=0),
                #helpText('If dosing is unknown or diverse, choose 0 (zero).'),
                sliderInput('Dose', 'Caffeine Dose (mg)', min=50, max=2000,
                            value=250, step=50),
                
                helpText('Red Bull®, 80 mg / Monster® and Rockstar®, 160 mg / 5 h Energy Extra
                         Strength® 242 mg'),
                
                sliderInput('Num', 'Simulations N', min=100, max=2000,
                            value=100, step=100)
            ),
            
            mainPanel(
                tableOutput("contents")
            )
        )
    ),
    tabPanel(
      title = "Cmax Plot",
      sidebarLayout(
        sidebarPanel(
          sliderInput('cmaxDose', 'Caffeine Dose (mg)', min=50, max=2000,
                      value=250, step=50),
          
          helpText('Red Bull®, 80 mg / Monster® and Rockstar®, 160 mg / 5 h Energy Extra
                   Strength® 242 mg'),
          
          sliderInput('cmaxNum', 'Simulations N', min=5, max=200,
                      value=20, step=5)
        ),
        
        mainPanel(
          plotOutput("plot"),
          helpText("Below 10 mg/L: generally considered safe (Green horizontal line)"),
          helpText("Over 40 mg/L: several fatalities (Blue horizontal line)"),
          helpText("Over 80 mg/L: fatal caffeine poisoning (Red horizontal line)"),
          helpText("Unit: BWT, kg, Cmax, mg/L, Reference: de Wijkerslooth LR et al.(2008), Seifert et al.(2013), Banerjee et al. (2014), Cannon et al. (2001)")
        )
      )
    ),
    tabPanel(
      title = "AUC Plot",
      sidebarLayout(
        sidebarPanel(
          sliderInput('aucDose', 'Caffeine Dose (mg)', min=50, max=2000,
                      value=250, step=50),
          
          helpText('Red Bull®, 80 mg / Monster® and Rockstar®, 160 mg / 5 h Energy Extra
                   Strength® 242 mg'),
          
          sliderInput('aucNum', 'Simulations N', min=5, max=200,
                      value=20, step=5)
          ),
        
        mainPanel(
          plotOutput("aucplot"),
          helpText("Unit: BWT, kg; AUC, mg/h/L")
          
        )
      )
),
    ### 5 ###
    tabPanel(
      title = "Help", 
      includeMarkdown("README.md")
    ),
    ### 6 ###
    tabPanel(
      title = "Contact", 
      includeMarkdown("CONTACT.md")
    )
)
