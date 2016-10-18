fn_script = "LDEF.R"
# see what LDEF curves look like using CEC Appliance standards database

# Jim Lutz "Fri Oct 14 11:14:55 2016"
# "2016-10-15 15:35:19 PDT"   sudo R then install.packages
# "Mon Oct 17 17:42:19 2016"  got git working

# make sure all packages loaded and start logging
# at some point I should turn this into a common file 
source("setup.R")


# set the working directory names 
source("setup_wd.R")

# load useful functions 
# source("functions.R") 
# not needed yet
# source("plotfunctions.R") # add as needed

# read the csv file from CEC Appliance standards data base
DT_WHs <- fread(input= paste0(wd_data,"CEC Small Gas and Oil Htrs 2016-10-15.csv"))

names(DT_WHs)
str(DT_WHs)

# make more convenient names
setnames(DT_WHs,c("Rated Volume","First Hour Rating","Input BTUH","Recovery Efficiency","Energy Factor")
         ,c("vol","FHR","Pon","RE","EF"))

# keep only Natural Gas
DT_WHs <- DT_WHs[grep("^Natural Gas$",`Energy Source`)]
# look at Energy Source
unique(DT_WHs$`Energy Source`)  

# get rid of old ones
# convert to dates
DT_WHs[,add_date:=mdy(DT_WHs$`Add Date`)]
summary(DT_WHs$`add_date`)
qplot(data=DT_WHs,x=`add_date`) + geom_histogram()

# DOE WH standards effective dates
DOE_2004 = mdy("January 20, 2004")# 2001 rulemaking, https://www.gpo.gov/fdsys/pkg/FR-2001-01-17/pdf/01-1081.pdf#page=2
DOE_2015 = mdy("April 16, 2015") # 2010 rulemaking, https://www.gpo.gov/fdsys/pkg/FR-2010-04-16/pdf/2010-7611.pdf#page=2

# keep only after 2004 standard
DT_WHs <- DT_WHs[add_date>=DOE_2004]

# keep only tanks > 20 gallons
DT_WHs <- DT_WHs[vol>20]



# Lutz, JD, CD Whitehead, AB Lekov, GJ Rosenquist, and DW Winiarski. 
# “WHAM: Simplified Tool for Calculating Water Heater Energy Use.” In ASHRAE Transactions, 
# Vol. 105. Chicago, IL: Lawrence Berkeley National Lab., CA (US), 1999.

# calculate standby loss coefficient
# use default assumptions for calculations
# UA = (1/EF - 1/RE) / ( (Ttank - Tamb) * ( 24 / Qout - 1/(RE*Pon))) 
# calculated at old EF test conditions.
Tdelta = 67.5 
Qout = 41904

# add UA to data.table
DT_WHs[,UA:=(1/EF - 1/(RE/100)) / ( (Tdelta) * ( 24 / Qout - 1/(RE*Pon)))]

# see what's in the database & remove nonsense records
str(DT_WHs)

# vol
summary(DT_WHs$vol)
qplot(data=DT_WHs,x=vol) + geom_histogram()

#FHR
summary(DT_WHs$FHR)
DT_WHs <- DT_WHs[!(is.na(FHR))]
DT_WHs[FHR<20] # this is a strange one
DT_WHs <- DT_WHs[FHR>20]
qplot(data=DT_WHs,x=FHR) + geom_histogram()
DT_WHs[FHR>150] # probably OK

# Pon
summary(DT_WHs$Pon)
qplot(data=DT_WHs,x=Pon) + geom_histogram()

# RE
summary(DT_WHs$RE)
qplot(data=DT_WHs,x=RE) + geom_histogram()
DT_WHs[RE<=72] # probably OK

# check EF
summary(DT_WHs$EF)
qplot(data=DT_WHs,x=EF) + geom_histogram()
DT_WHs[EF<=.50] # large tanks
qplot(data = DT_WHs,x=vol,y=EF) # OK those are biggies

# check UA
summary(DT_WHs$UA)
qplot(data=DT_WHs,x=UA) + geom_histogram()

# scatter plots
ggpairs(DT_WHs, columns = c("vol","FHR","Pon","RE","EF","UA"), upper="blank")




