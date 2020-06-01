# Clear the environment
rm(list = ls())

#Load the necessary libraries
library(deSolve) # Contains DE solvers
library(ggplot2) # plotting
library(gridExtra)
library(grid)

# Set the working directory
#- Make sure of the directory
setwd("C:/Users/94720/Desktop") 


# load the parameter values 
# Lambda, beta_c, sigma, taua, pn, mu, pp, gamma, tau
source("Parameters.R")

# Bring in the DE model
source("Fun.DEModelConstantPopulation.R")

# run the DE Model
TFinal <- 3000 # Length of time of the simulation
dt <- 2^-3 # time step of data that is returned

# Set up the initial conditions for the model
# initialConds <- c(Sneg = 8252, Spos = 81, Ineg = 1333, Iapos = 83, Ispos = 250)
# initialConds <- c(S = 0.7, I = 0.3)
# initialConds <- c(S = 0.75, Ia = 0.15, Is = 0.1)
  initialConds <- c(S = 0.8, Ianeg = 0.1, Iapos = 0.06, Is = 0.04)

#sol <- DEModelConstantPopulation(parameters, initialConds, TFinal, dt)
#sol.df = as.data.frame(sol)

#Create 9*5 empty matrix x with column names
x <- matrix(nrow = 9,ncol = 5)
colnames(x) <- c("Stau", "S", "Ianeg", "Iapos", "Is")

#Create a empty list to store plots
plots <- list()

#Parameter sigma loop
for(j in 1:5){
  
 #sigma = 0.2, 0.4, 0.6, 0.8, 1 
 parameters["sigma"] = as.double(j*2/10)
 
 #Parameter Sigmatau(Stau) loop
 for(i in 1:9){
   
   #sigmatau = 0.1 - 0.9
   parameters["Stau"]= as.double(i/10)
  
   #run simulation
   sol <- DEModelConstantPopulation(parameters, initialConds, TFinal, dt)
   #sol is a data frame with 3000 rows and 5 columns (time, S, Ianeg, Iapos, Is)
   sol.df = as.data.frame(sol)
   
   #Fill matrix x 
   #x is now a matrix with 9 rows and 5 columns(taus,S,Ianeg,Iapos,Is) .
   x[i,1] <- as.double(i/10)
   x[i,2] <- sol.df[3000,2]
   x[i,3] <- sol.df[3000,3]
   x[i,4] <- sol.df[3000,4]
   x[i,5] <- sol.df[3000,5]
 }

#Uncomment the following line to get matrix x.
#print(x)

# Plot the results
  x.df <- as.data.frame(x)
  #plotSol <- ggplot(x.df, aes(x = taus)) +
 
  p <-  ggplot(x.df, aes(x = Stau)) +                  
  #geom_point(aes(y=S), color = "blue") +
  geom_point(aes(y=Ianeg), color = "red") +
  geom_point(aes(y=Iapos), color = "green") +
  geom_point(aes(y=Is), color = "yellow") +  
    
#plotSol <- ggplot(sol.df, aes(x=time))+ 
  
#+ geom_line(aes(y=Sneg), color = "blue") 
#+ geom_line(aes(y=Spos), color = "red")
#+ geom_line(aes(y=Ineg), color = "green")
#+ geom_line(aes(y=Iapos), color = "yellow")
#+ geom_line(aes(y=Ispos), color = "black")

 # geom_line(aes(y=S), color = "blue")+
 # geom_line(aes(y=I), color = "red")+
   
 # geom_line(aes(y=S), color = "blue")+
 # geom_line(aes(y=Ia), color = "red")+
 # geom_line(aes(y=Is), color = "Green")+
    
 # geom_line(aes(y=S), color = "blue") +
 # geom_line(aes(y=Ianeg), color = "red") +
 # geom_line(aes(y=Iapos), color = "green") +
 # geom_line(aes(y=Is), color = "yellow") +

 #Set the appearance of the plots
 labs(title = "Groups Over Stau", 
       subtitle = paste("Sigma =", parameters["sigma"]),
       #x = "Time",
       x = "Stau",
       y="# of People") +
  
  theme(plot.title = element_text(size = 8),
        plot.subtitle = element_text(size = 6),
        axis.title.x = element_text(size = 7),
        axis.title.y = element_text(size = 7),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_text(size = 6))
  
  plots[[j]] <- p
}  

#Arrange five plots in one page
figure <- grid.arrange(plots[[1]],plots[[2]], plots[[3]],plots[[4]],plots[[5]], ncol=2)
#print(plotSol)
print(figure)

