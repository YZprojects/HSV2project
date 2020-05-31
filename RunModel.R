# Clear the environment
rm(list = ls())

#Load the necessary libraries
library(deSolve) # Contains DE solvers
library(ggplot2) # plotting
#library(ggpubr)
library(gridExtra)
library(grid)
# Set the working directory
setwd("C:/Users/94720/Desktop") #- Make sure of the directory


# load the parameter values 
# Lambda, beta_c, sigma, taua, pn, mu, pp, gamma, tau
source("Parameters.R")

# Bring in the DE model
source("Fun.DEModelConstantPopulation.R")

# run the DE Model
TFinal <- 3000 # Length of time of the simulation
dt <- 2^-3 # time step of data that is returned

# Set up the initial conditions for the model

# Sneg, Spos, Ineg, Iapos, Ispos
# initialConds <- c(Sneg = 8252, Spos = 81, Ineg = 1333, Iapos = 83, Ispos = 250)
 # initialConds <- c(S = 0.7, I = 0.3)
 #initialConds <- c(S = 0.75, Ia = 0.15, Is = 0.1)
 initialConds <- c(S = 0.8, Ianeg = 0.1, Iapos = 0.06, Is = 0.04)

#sol <- DEModelConstantPopulation(parameters, initialConds, TFinal, dt)

#sol.df = as.data.frame(sol)

#print(sol.df[3000,3])

x <- matrix(nrow = 9,ncol = 5)
colnames(x) <- c("taus", "S", "Ianeg", "Iapos", "Is")


#for(j in 1:2){
  
#parameters["sigma"] = as.double(j/10)
  
 for(i in 1:9){
   parameters["sigma"] = 0.1
   parameters["taus"]= as.double(i/10)
  
   sol <- DEModelConstantPopulation(parameters, initialConds, TFinal, dt)
   sol.df = as.data.frame(sol)
 
   x[i,1] <- as.double(i/10)
   x[i,2] <- sol.df[3000,2]
   x[i,3] <- sol.df[3000,3]
   x[i,4] <- sol.df[3000,4]
   x[i,5] <- sol.df[3000,5]
 } 
#print(x)

# Plot the results
  x.df <- as.data.frame(x)
  #plotSol <- ggplot(x.df, aes(x = taus)) +
  g1<-  ggplot(x.df, aes(x = taus)) +                  
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

 labs(title="Groups Over Taus", 
       #x = "Time",
       x = "Taus",
       y="Number of People")
   

for(i in 1:9){
  parameters["sigma"] = 0.2
  parameters["taus"]= as.double(i/10)
  
  sol <- DEModelConstantPopulation(parameters, initialConds, TFinal, dt)
  sol.df = as.data.frame(sol)
  
  x[i,1] <- as.double(i/10)
  x[i,2] <- sol.df[3000,2]
  x[i,3] <- sol.df[3000,3]
  x[i,4] <- sol.df[3000,4]
  x[i,5] <- sol.df[3000,5]
}
#print(x)

# Plot the results
x.df <- as.data.frame(x)
#plotSol <- ggplot(x.df, aes(x = taus)) +
g2<-  ggplot(x.df, aes(x = taus)) +                  
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

labs(title="Groups Over Taus", 
     #x = "Time",
     x = "Taus",
     y="Number of People")

figure <- grid.arrange(g1,g2)
#print(plotSol)
print(figure)

