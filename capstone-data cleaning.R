library(dplyr)
library(lubridate)
setwd("C:/Users/shhwa/DS 340H")

## Data Reading----------------

Jan20 <- read.csv("202001-bluebikes-tripdata.csv") %>% select("starttime")
Feb20 <- read.csv("202002-bluebikes-tripdata.csv") %>% select("starttime")
Mar20 <- read.csv("202003-bluebikes-tripdata.csv") %>% select("starttime")
Apr20 <- read.csv("202004-bluebikes-tripdata.csv") %>% select("starttime")
May20 <- read.csv("202005-bluebikes-tripdata.csv") %>% select("starttime")
Jun20 <- read.csv("202006-bluebikes-tripdata.csv") %>% select("starttime")
Jul20 <- read.csv("202007-bluebikes-tripdata.csv") %>% select("starttime")
Aug20 <- read.csv("202008-bluebikes-tripdata.csv") %>% select("starttime")
Sep20 <- read.csv("202009-bluebikes-tripdata.csv") %>% select("starttime")
Oct20 <- read.csv("202010-bluebikes-tripdata.csv") %>% select("starttime")
Nov20 <- read.csv("202011-bluebikes-tripdata.csv") %>% select("starttime")
Dec20 <- read.csv("202012-bluebikes-tripdata.csv") %>% select("starttime")

Jan21 <- read.csv("202101-bluebikes-tripdata.csv") %>% select("starttime")
Feb21 <- read.csv("202102-bluebikes-tripdata.csv") %>% select("starttime")
Mar21 <- read.csv("202103-bluebikes-tripdata.csv") %>% select("starttime")
Apr21 <- read.csv("202104-bluebikes-tripdata.csv") %>% select("starttime")
May21 <- read.csv("202105-bluebikes-tripdata.csv") %>% select("starttime")
Jun21 <- read.csv("202106-bluebikes-tripdata.csv") %>% select("starttime")
Jul21 <- read.csv("202107-bluebikes-tripdata.csv") %>% select("starttime")
Aug21 <- read.csv("202108-bluebikes-tripdata.csv") %>% select("starttime")
Sep21 <- read.csv("202109-bluebikes-tripdata.csv") %>% select("starttime")
Oct21 <- read.csv("202110-bluebikes-tripdata.csv") %>% select("starttime")
Nov21 <- read.csv("202111-bluebikes-tripdata.csv") %>% select("starttime")
Dec21 <- read.csv("202112-bluebikes-tripdata.csv") %>% select("starttime")

Jan22 <- read.csv("202201-bluebikes-tripdata.csv") %>% select("starttime")
Feb22 <- read.csv("202202-bluebikes-tripdata.csv") %>% select("starttime")
Mar22 <- read.csv("202203-bluebikes-tripdata.csv") %>% select("starttime")
Apr22 <- read.csv("202204-bluebikes-tripdata.csv") %>% select("starttime")
May22 <- read.csv("202205-bluebikes-tripdata.csv") %>% select("starttime")
Jun22 <- read.csv("202206-bluebikes-tripdata.csv") %>% select("starttime")
Jul22 <- read.csv("202207-bluebikes-tripdata.csv") %>% select("starttime")
Aug22 <- read.csv("202208-bluebikes-tripdata.csv") %>% select("starttime")
Sep22 <- read.csv("202209-bluebikes-tripdata.csv") %>% select("starttime")
Oct22 <- read.csv("202210-bluebikes-tripdata.csv") %>% select("starttime")
Nov22 <- read.csv("202211-bluebikes-tripdata.csv") %>% select("starttime")
Dec22 <- read.csv("202212-bluebikes-tripdata.csv") %>% select("starttime")

Jan23 <- read.csv("202301-bluebikes-tripdata.csv") %>% select("starttime")
Feb23 <- read.csv("202302-bluebikes-tripdata.csv") %>% select("starttime")
Mar23 <- read.csv("202303-bluebikes-tripdata.csv") %>% select("starttime")
Apr23 <- read.csv("202304-bluebikes-tripdata.csv") %>% select("started_at")
May23 <- read.csv("202305-bluebikes-tripdata.csv") %>% select("started_at")
Jun23 <- read.csv("202306-bluebikes-tripdata.csv") %>% select("started_at")
Jul23 <- read.csv("202307-bluebikes-tripdata.csv") %>% select("started_at")
Aug23 <- read.csv("202308-bluebikes-tripdata.csv") %>% select("started_at")
Sep23 <- read.csv("202309-bluebikes-tripdata.csv") %>% select("started_at")
Oct23 <- read.csv("202310-bluebikes-tripdata.csv") %>% select("started_at")
Nov23 <- read.csv("202311-bluebikes-tripdata.csv") %>% select("started_at")
Dec23 <- read.csv("202312-bluebikes-tripdata.csv") %>% select("started_at")

Jan24 <- read.csv("202401-bluebikes-tripdata.csv") %>% select("started_at")
Feb24 <- read.csv("202402-bluebikes-tripdata.csv") %>% select("started_at")
Mar24 <- read.csv("202403-bluebikes-tripdata.csv") %>% select("started_at")
Apr24 <- read.csv("202404-bluebikes-tripdata.csv") %>% select("started_at")
May24 <- read.csv("202405-bluebikes-tripdata.csv") %>% select("started_at")
Jun24 <- read.csv("202406-bluebikes-tripdata.csv") %>% select("started_at")
Jul24 <- read.csv("202407-bluebikes-tripdata.csv") %>% select("started_at")
Aug24 <- read.csv("202408-bluebikes-tripdata.csv") %>% select("started_at")
Sep24 <- read.csv("202409-bluebikes-tripdata.csv") %>% select("started_at")
Oct24 <- read.csv("202410-bluebikes-tripdata.csv") %>% select("started_at")
Nov24 <- read.csv("202411-bluebikes-tripdata.csv") %>% select("started_at")
Dec24 <- read.csv("202412-bluebikes-tripdata.csv") %>% select("started_at")

## Bike Ride count---------------
bbtotal <- rbind(Jan20, Feb20, Mar20, Apr20, May20, Jun20, Jul20, Aug20, 
                 Sep20, Oct20, Nov20, Dec20,
                 Jan21, Feb21, Mar21, Apr21, May21, Jun21, Jul21, Aug21, 
                 Sep21, Oct21, Nov21, Dec21,
                 Jan22, Feb22, Mar22, Apr22, May22, Jun22, Jul22, Aug22,
                 Sep22, Oct22, Nov22, Dec22, 
                 Jan23, Feb23, Mar23)
bbtotal2 <- rbind(Apr23, May23, Jun23, Jul23, Aug23, 
                  Sep23, Oct23, Nov23, Dec23,
                  Jan24, Feb24, Mar24, Apr24, May24, Jun24, Jul24, Aug24,
                  Sep24, Oct24, Nov24, Dec24)
bbtotal$starttime <- ymd_hms(bbtotal$starttime)
colnames(bbtotal2) <- "starttime"
bbtotal2 <- ymd_hms(bbtotal2)

bbtotal3 <- rbind(bbtotal, bbtotal2)

bluebike_weekly <- bbtotal3 %>%
  mutate(week_start = floor_date(starttime, unit = "week", week_start = 1)) %>% 
  count(week_start) %>%
  rename(count_per_week = n)

## Data Merging + Cleaning----------------
## gas prices https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=pet&s=emm_epm0_pte_sma_dpg&f=w
bos_gas <- read.csv("Weekly_Massachusetts_Gasoline_Prices.csv")
colnames(bos_gas) <- c("week_start", "gas_price")
bos_gas$week_start <- mdy(bos_gas$week_start) #change to datetime
bluebike_weekly <- left_join(bluebike_weekly, bos_gas, by = "week_start") #merge

## COVID https://www.boston.gov/government/cabinets/boston-public-health-commission/covid-19-dashboard
bos_covid <- read.csv("boston-covid-counts.csv") %>% select("date_value_start","value")
bos_covid <- bos_covid[1:1799,]
colnames(bos_covid) <- c("time", "new_covid_cases")
bos_covid$time <- ymd(bos_covid$time)
#set date range
bos_covid <- bos_covid %>%
  filter(time >= as.Date("2019-12-30") & time <= as.Date("2024-12-31"))
#get weekly average
start_day <- as.Date("2019-12-30")
weekly_bos_covid <- bos_covid %>%
  mutate(time = start_day + 7 * ((as.integer(difftime(time, start_day, units = "days")) %/% 7))) %>%
  group_by(time) %>%
  summarise(across(c(new_covid_cases), ~ mean(.x, na.rm = TRUE)))
colnames(weekly_bos_covid)[colnames(weekly_bos_covid) == 'time'] <- 'week_start' #match colname
bluebike_weekly <- full_join(bluebike_weekly, weekly_bos_covid, by = "week_start") #merge 

## weather 
bos_weather <- read.csv("boston_weather_data.csv")
bos_weather$time <- ymd(bos_weather$time)
#set date range
bos_weather <- bos_weather %>%
  filter(time >= as.Date("2019-12-30") & time <= as.Date("2024-12-31"))
#get weekly average
start_day <- as.Date("2019-12-30")
weekly_bos_weather <- bos_weather %>%
  mutate(time = start_day + 7 * ((as.integer(difftime(time, start_day, units = "days")) %/% 7))) %>%
  group_by(time) %>%
  summarise(across(c(tavg, prcp, wspd), ~ mean(.x, na.rm = TRUE)))
colnames(weekly_bos_weather)[colnames(weekly_bos_weather) == 'time'] <- 'week_start' #match colname
bluebike_weekly <- full_join(bluebike_weekly, weekly_bos_weather, by = "week_start") #merge 

## assign month & season
bluebike_weekly$month <- as.numeric(format(bluebike_weekly$week_start, "%m")) #month

assign_season <- function(date) {
  month_val <- month(date)
  day_val <- day(date)
  
  if (month_val == 12 || month_val == 1 || month_val == 2 || 
      (month_val == 3 && day_val <= 20)) {
    return("Winter")
  } else if (month_val == 3 && day_val >= 21 || month_val == 4 || month_val == 5) {
    return("Spring")
  } else if (month_val == 6 || month_val == 7 || month_val == 8 || 
             (month_val == 9 && day_val <= 20)) {
    return("Summer")
  } else if (month_val == 9 && day_val >= 21 || month_val == 10 || month_val == 11) {
    return("Fall")
  }
}

bluebike_weekly$season <- sapply(bluebike_weekly$week_start, assign_season)
#fill in covid counts as 0 - this is pre-establishment of covid board/pandemic
bluebike_weekly[is.na(bluebike_weekly)] <- 0

#write to csv
write.csv(bluebike_weekly, "bluebike_weekly.csv")