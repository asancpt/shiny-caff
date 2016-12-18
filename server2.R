library(shiny)
library(ggplot2)
library(dplyr)
library(markdown)
library(mgcv)
library(psych)
CaffSigma <- matrix(c(0.1599, 6.095e-2, 9.650e-2, 
                      6.095e-2, 4.746e-2, 1.359e-2, 
                      9.650e-2, 1.359e-2, 1.004), nrow = 3)
CaffMu = c(0,0,0)

#set.seed(20140523+1)
#BWT = 25; Dose = 80
Dataset <- function(BWT, Dose, Num){
    #set.seed(20140523+1)
    MVN <- rmvn(Num, CaffMu, CaffSigma);  
    MVNdata <- data.frame(MVN, stringsAsFactors = FALSE) %>% 
        select(eta1 = X1, eta2 = X2, eta3 = X3) %>% 
        mutate(CL = 0.09792 * BWT * exp(eta1), # L/hr
               V  = 0.7219 * BWT * exp(eta2), # L, TVV =THETA[2] * (1 + ABST*THETA[7]) [1] 0.7218775
               Ka = 4.268 * exp(eta3), # /hr
               Ke = CL / V) %>%  
        mutate(Tmax = (log(Ka) - log(Ke)) / (Ka - Ke),
               Cmax = Dose / V * Ka / (Ka - Ke) * (exp(-Ke * Tmax) - exp(-Ka * Tmax)), 
               AUC  = Dose / CL, # mg/h/L
               Half_life = 0.693 / Ke) %>% select(-eta1, -eta2, -eta3)
    return(MVNdata)
}

Simul <- function(df){
    MVNSimulRaw <- describe(df) 
    MVNSimulRaw[, "Parameters"] <- row.names(MVNSimulRaw)
    MVNSimul <- MVNSimulRaw %>% select(Parameters, median, sd, min, max)
    return(MVNSimul)
}

shinyServer(function(input, output, session) {
    
    output$contents <- renderTable({
        ### Start ###
        return(Simul(Dataset(input$BWT, input$Dose, input$Num)))
    })
    
    output$plot <- renderPlot({
        #ggDset <- Dataset(20,300,10) %>% #(i, input$Dose, 100) %>% 
        #                       select(Tmax, Cmax, AUC, Half_life, CL, V) %>% 
        #  mutate(BWT)
        ggDset <- data.frame()
        Rnorm <- c(23, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 84)
        for (i in 1:length(Rnorm)){
            ggDset <- bind_rows(
                ggDset,
                Dataset(Rnorm[i], input$cmaxDose, input$cmaxNum) %>% select(Tmax, Cmax, AUC, Half_life, CL, V) %>% 
                    mutate(BWT = Rnorm[i])
            )
        }
        p <- ggplot(ggDset, aes(x=BWT, y=Cmax, colour=Cmax)) + #
            geom_point() + geom_hline(yintercept = 10, colour="green") + 
            geom_hline(yintercept = 80, colour="red") + 
            geom_hline(yintercept = 40, colour="blue")
        print(p)
    })
    
    output$aucplot <- renderPlot({
        #ggDset <- Dataset(20,300,10) %>% #(i, input$Dose, 100) %>% 
        #                       select(Tmax, Cmax, AUC, Half_life, CL, V) %>% 
        #  mutate(BWT)
        ggDset <- data.frame()
        Rnorm <- c(23, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 84)
        for (i in 1:length(Rnorm)){
            ggDset <- bind_rows(
                ggDset,
                Dataset(Rnorm[i], input$aucDose, input$aucNum) %>% select(Tmax, Cmax, AUC, Half_life, CL, V) %>% 
                    mutate(BWT = Rnorm[i])
            )
        }
        p <- ggplot(ggDset, aes(x=BWT, y=AUC, colour=AUC)) + #
            geom_point()
        print(p)
    })
})
