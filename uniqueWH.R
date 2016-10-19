fn_script = "uniqueWH.R"
# reduce water heater to just unique 'base' models
# same EF, RE, UA, vol, Pon, FHR

# Jim Lutz "2016-10-18 16:40:23 PDT"

# make sure all packages loaded and start logging
# at some point I should turn this into a common file 
source("setup.R")

# set the working directory names 
source("setup_wd.R")

# load DT_WHs
load(file = paste0(wd_data,"DT_WHs.RData"))

# keep only EF, RE, UA, vol, Pon, FHR
DT_WHs_reduced <- DT_WHs[,list(vol,FHR,Pon,RE,EF,UA)] 

# build a unique identifier for base models
str(DT_WHs_reduced)
DT_WHs_reduced[,uid:= sprintf("%03d_%03d_%03.0f_%03d_%03.0f_%03d",vol,Pon/1000,EF*100,RE*100,UA*10,FHR)]

# sort by uid
setkey(DT_WHs_reduced,uid)

# count by uid
DT_WHs_unique <- DT_WHs_reduced[,list(vol,Pon,EF,RE,UA,FHR,n=length(vol)),by=uid][J(unique(uid)),mult="first"]

# save data.table
save(DT_WHs_unique , file=paste0(wd_data,"DT_WHs_unique.RData"))


