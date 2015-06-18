# set working directory
setwd("/Volumes/HD2/Users/pstessel/Documents/Git_Repos/medicare")

# clear global environment
rm(list=ls())

require(data.table)
require(dplyr)
require(rattle)

# read-in yearly data files
# med2011 <- read.csv("data/Medicare_Provider_Charge_Inpatient_DRG100_FY2011.csv", header = TRUE, sep = ",", quote = "\"",
#          dec = ".", fill = TRUE, comment.char = "")
med2011 <- fread("data/Medicare_Provider_Charge_Inpatient_DRG100_FY2011.csv")
med2012 <- fread("data/Medicare_Provider_Charge_Inpatient_DRG100_FY2012.csv")
med2013 <- fread("data/Medicare_Provider_Charge_Inpatient_DRG100_FY2013.csv")

# add a year column to each data set
med2011$year  <- "2011"
med2012$year  <- "2012"
med2013$year  <- "2013"

# combine all years
l = list(med2011, med2012, med2013)
med_all <- rbindlist(l)

# load generic variables
dsname <- "med_all"
ds <- get(dsname)
names(ds)

# normalize variable names
o_names <- names(med_all)
n_names <- c("drg_definition", "provider_id", 
             "provider_name", "provider_street_address", 
             "provider_city", "provider_state", "provider_zip code", 
             "hospital_referral_region", "total_discharges", "avg_covered_charges", 
             "avg_total_payments", "avg_medicare_payments", "year")
setnames(ds, o_names, n_names)

# extract unique providers to a new dataset for geocoding
setkey(ds, provider_id)
# unique addresses are determined by the key, "provider_id"
uniqaddresses <- subset(unique(ds))
write.csv(uniqaddresses, "uniqaddresses.csv")
