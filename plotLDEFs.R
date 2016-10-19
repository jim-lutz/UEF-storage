fn_script = "plotLDEFs.R"
# plot LDEFs for unique 'base' models

# Jim Lutz "2016-10-18 17:24:34 PDT"

# make sure all packages loaded and start logging
# at some point I should turn this into a common file 
source("setup.R")

# set the working directory names 
source("setup_wd.R")

# load DT_WHs
load(file = paste0(wd_data,"DT_WHs_unique.RData"))
DT_WHs_unique

# function to calculate Qin from
# Lutz, JD, CD Whitehead, AB Lekov, GJ Rosenquist, and DW Winiarski. 
# “WHAM: Simplified Tool for Calculating Water Heater Energy Use.” In ASHRAE Transactions, 
# Vol. 105. Chicago, IL: Lawrence Berkeley National Lab., CA (US), 1999.

Qin <- function(RE, UA, Pon, vol_daily, Ttank=135, Tin=58, Tamb=67.5, den=8.293, Cp=0.9981) {
  # This is the WHAM eqn
  # RE, UA, Pon describe the water heater
  # vol_daily is the daily hot water drawn
  # den =  8.293 lb/gal at 96.5 °F
  # Cp  =  0.9981 Btu/(lbm °F) at 96.5 °F

  Qin = (vol_daily * den * Cp * (Ttank - Tin))/RE * 
         ( 1 - (UA * (Ttank - Tamb))/Pon) 
         + 24 * UA * (Ttank - Tamb)

  # testing
  for(v in c("RE", "UA", "Pon", "vol_daily", "Ttank", "Tin", "Tamb", "den", "Cp")) {
    cat(v," = ", get(v),"\n") 
  }
  
  
  return(Qin)
}

# test Qin
# EF should equal Qout/Qin @ Qout = 41904 & vol_daily = 61.3
RE = (DT_WHs_unique[1]$RE)/100 # convert to fraction
UA = DT_WHs_unique[1]$UA
Pon = DT_WHs_unique[1]$Pon
vol_daily=61.3
Qout = 41904

Q_in <- Qin(RE=RE,UA=UA,Pon=Pon,vol_daily = vol_daily)

Qout/Q_in
DT_WHs_unique[1]$EF

