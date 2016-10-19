# LDEF

see what LDEF curves look like using CEC Appliance standards database
scripts to generate LDEF curves for use in 2016 ACM water heating

readWHdata.R
  imports, cleans & checks data from a csv file exported from the CEC appliance database.
    calls:  setup.R (which calls logging.R), setup_wd.R, 
    input:  CEC Small Gas and Oil Htrs 2016-10-15.csv
    output: DT_WHs.RData

uniqueWH.R
  reduceS water heater data set to just unique 'base' models of same EF, RE, UA, vol, Pon, FHR
    calls:  setup.R (which calls logging.R), setup_wd.R, 
    input:  DT_WHs.RData
    output: DT_WHs_unique.RData

plotLDEFs.R
WHAM equation not working. Check w/ spreadsheet
RE  =  0.76 
UA  =  7.691232 
Pon  =  30000 
vol_daily  =  61.3 
Ttank  =  135 
Tin  =  58 
Tamb  =  67.5 
den  =  8.293 
Cp  =  0.9981 
> Qout
[1] 41904
> Q_in
[1] 50517.51
> DT_WHs_unique[1]$EF
[1] 0.62
> Qout/Q_in
[1] 0.8294945

