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

