fn_script = "plotLDEFs.R"
# plot LDEFs for unique 'base' models

# Jim Lutz "2016-10-18 17:24:34 PDT"
# "Wed Oct 19 15:29:59 2016"    find out why EF != Qout/Qin  

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

Qin <- function(RE, UA, Pon, vol_daily=64.3, Ttank=135, Tin=58, Tamb=67.5, den=8.2938, Cp=1.0007, test=FALSE) {
  # This is the WHAM eqn
  # RE, UA, Pon describe the water heater
  # vol_daily is the daily hot water drawn, default is test conditions
  # default properties of water from 'WHAM model Lutz.xls'
  # den =  8.2938	lb/gal		Density of water at average temperature.
  # Cp  =  1.0007	Btu/lb-deg F		Specific heat of water at average temperature.

  Qin = (vol_daily * den * Cp * (Ttank - Tin))/RE * 
         ( 1 - (UA * (Ttank - Tamb))/Pon) 
         + 24 * UA * (Ttank - Tamb)

  # testing only
  if (test) {
    for(v in c("RE", "UA", "Pon", "vol_daily", "Ttank", "Tin", "Tamb", "den", "Cp")) {
      cat(v," = ", get(v),"\n") 
    }
  }
  
  
  return(Qin)
}

# add Qin to data.table
DT_WHs_unique[,Qin_daily:=Qin(RE,UA,Pon)]

# test Qin_daily
DT_WHs_unique[1]

with(DT_WHs_unique[1],{
  Qin(RE,UA,Pon,test=TRUE)
})

Qout/Q_in
DT_WHs_unique[1]$EF

