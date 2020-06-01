
# set the parameter values

parameters <- c(Lambda = 0.0125, # birth rate
                mu = 0.016175,# exit rate
                beta_c = 0.0188147,#0.015678246842907; % transmission rate
                p = 0.8, 
                pn = 0.90, # probability patient is tested neg given that they are negative
                pp = 0.98, # propability patient is tested positive given that they are positive
                gamma = 0.00404, #0.000625; % rate of developing symptoms for the first time
                sigma = 0.7, #1 , serosorting
                taua = 0.4, #0.000952250243160; % testing rate
                taus = 1) # assume people with symptoms get tested

