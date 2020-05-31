DEModelConstantPopulation <- function(parameters,initialConds,TFinal, dt){
  
##########################################################
#
# DEModel runs the HSV model. The parameters are sent in a list 
# with each parameter having it's proper name. Initial conditions
# are also sent. TFinal is the end time of the simulation.
# dt is the time step for the returned data.
#
# In this case, the entrance into Sneg is the same as the
# exit out of all of the compartments to keep the population
# size the same over time.
#
##########################################################
  

  # set up the DE
  HSV_Trans <- function(t, state, parameters) {
     with(as.list(c(state)),{
       
       # Npos is Ispos under the null hypothesis and Nneg is the complement
       #Nneg <- Sneg + Spos + Ineg + Iapos
       #Npos <- Ispos
        N <- S + Ianeg + Iapos + Is
        #N <- S + I
        #N <- S + Ia + Is
       # lambdaneg and lambdapos are the same under the null hypothesis
       #lambdaneg <- parameters["beta_c"]*(parameters["sigma"]*(Ineg + Iapos)/Nneg + 
                                  #(1-parameters["sigma"])*(Ineg + Iapos + Ispos)/(Nneg + Npos))
       #lambdapos <- lambdaneg
       
       # rate of change, here we let the entrance equal the exit and have everyone entering into susceptible
       #dSneg  <- parameters["mu"]*(Nneg+Npos) - (lambdaneg + parameters["taua"]*(1-parameters["pn"]) + parameters["mu"])*Sneg
       #dSpos  <- parameters["taua"]*(1 - parameters["pn"])*Sneg - (lambdapos + parameters["mu"])*Spos
       #dIneg  <- lambdaneg*Sneg - (parameters["taua"]*parameters["pp"] + parameters["gamma"] + parameters["mu"])*Ineg
       #dIapos  <- parameters["taua"]*parameters["pp"]*Ineg + lambdapos*Spos - parameters["gamma"]*Iapos - parameters["mu"]*Iapos
       #dIspos <- parameters["gamma"]*(Ineg+Iapos) - parameters["mu"]*Ispos
      
       #dS <- parameters["mu"]*N - parameters["sigma"]*parameters["beta_c"]*S*Is - parameters["beta_c"]*S*(Ianeg+parameters["taus"]*Iapos) - parameters["mu"]*S
       #dIaneg <- parameters["p"]*(parameters["sigma"]*parameters["beta_c"]*S*Is + parameters["beta_c"]*S*(Ianeg+parameters["taus"]*Iapos)) - parameters["taua"]*Ianeg - parameters["mu"]*Ianeg
       #dIapos <- parameters["taua"]*Ianeg - parameters["mu"]*Iapos
       #dIs <- (1-parameters["p"])*(parameters["sigma"]*parameters["beta_c"]*S*Is + parameters["beta_c"]*S*(Ianeg+parameters["taus"]*Iapos)) - parameters["mu"]*Is
       
       #dS <- parameters["mu"]*(S+I) - parameters["beta_c"]*S*I -parameters["mu"]*S 
       #dI <- parameters["beta_c"]*S*I -parameters["mu"]*I
       
       #dS <- parameters["mu"]*(S+Ia+Is) - parameters["beta_c"]*S*(Ia+Is) -parameters["mu"]*S 
       #dIa <- parameters["beta_c"]*S*(Ia+Is) -(parameters["gamma"]+parameters["mu"])*Ia 
       #dIs <- parameters["gamma"]*Ia -parameters["mu"]*Is
        
        #dS <- parameters["mu"]*(S+Ia+Is) - parameters["beta_c"]*S*(Ia+Is) -parameters["mu"]*S 
       # dIa <- parameters["p"]*parameters["beta_c"]*S*(Ia+Is) -parameters["mu"]*Ia 
       # dIs <- (1-parameters["p"])*parameters["beta_c"]*S*(Ia+Is) -parameters["mu"]*Is
        
        #testing model
        dS <- parameters["mu"]*N - parameters["sigma"]*parameters["beta_c"]*S*Is - parameters["beta_c"]*S*(Ianeg+parameters["taus"]*Iapos)-parameters["mu"]*S
        dIaneg <- parameters["p"]*(parameters["sigma"]*parameters["beta_c"]*S*Is +parameters["beta_c"]*S*(Ianeg+parameters["taus"]*Iapos)) - parameters["taua"]*Ianeg - parameters["mu"]*Ianeg
        dIapos <- parameters["taua"]*Ianeg - parameters["mu"]*Iapos
        dIs <- (1-parameters["p"])*(parameters["sigma"]*parameters["beta_c"]*S*Is + parameters["beta_c"]*S*(Ianeg+parameters["taus"]*Iapos)) - parameters["mu"]*Is
        
       # return the rate of change
       # list(c(dSneg, dSpos, dIneg, dIapos, dIspos))
       # list(c(dS, dI))
       # list(c(dS,dIa,dIs))
       list(c(dS, dIaneg, dIapos, dIs))
        }) # end with(as.list ...
    }
  
  # state is the initial condition and times are the output times
  times <- seq(0,TFinal, dt)

  # Run the model using the ode function.
  #Last Value is returned
  out <- ode(y = initialConds, times = times, func = HSV_Trans, parms = parameters) 


}


