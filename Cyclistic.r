#Import all libraries in R
library(dplyr)
library(tidyr)
library(skimr)
library(janitor)
library(lubridate)
library(ggplot2)
#Assign all csv files to a variable
trips_2021_08<-read.csv("../input/d/jjean95/cyclistic-dataset/202108-divvy-tripdata.csv")
trips_2021_09<-read.csv("../input/d/jjean95/cyclistic-dataset/202109-divvy-tripdata.csv")
trips_2021_10<-read.csv("../input/d/jjean95/cyclistic-dataset/202110-divvy-tripdata.csv")
trips_2021_11<-read.csv("../input/d/jjean95/cyclistic-dataset/202111-divvy-tripdata.csv")
trips_2021_12<-read.csv("../input/d/jjean95/cyclistic-dataset/202112-divvy-tripdata.csv")
trips_2022_01<-read.csv("../input/d/jjean95/cyclistic-dataset/202201-divvy-tripdata.csv")
trips_2022_02<-read.csv("../input/d/jjean95/cyclistic-dataset/202202-divvy-tripdata.csv")
trips_2022_03<-read.csv("../input/d/jjean95/cyclistic-dataset/202203-divvy-tripdata.csv")
trips_2022_04<-read.csv("../input/d/jjean95/cyclistic-dataset/202204-divvy-tripdata.csv")
trips_2022_05<-read.csv("../input/d/jjean95/cyclistic-dataset/202205-divvy-tripdata.csv")
trips_2022_06<-read.csv("../input/d/jjean95/cyclistic-dataset/202206-divvy-tripdata.csv")
trips_2022_07<-read.csv("../input/d/jjean95/cyclistic-dataset/202207-divvy-tripdata.csv")
#Shows top 6 rows of data
head(trips_2021_08)
#Looking at the structure of the data
str(trips_2021_08)
#Merge them into single csv
Trips_2021_2022 <- rbind(trips_2021_08,trips_2021_09,trips_2021_10,trips_2021_11,trips_2021_12,trips_2022_01,trips_2022_02,trips_2022_03,trips_2022_04,trips_2022_05,trips_2022_06,trips_2022_07)
#Calculate the difference between started_at and ended_at
Trips_2021_2022$ride_length <- difftime(Trips_2021_2022$ended_at,Trips_2021_2022$started_at)
#Adding day of the week column
Trips_2021_2022$day_of_week <- format(as.Date(Trips_2021_2022$started_at), "%A")
#Remove the bad data by filtering out the negative value in the ride_length
Trips_2021_2022 <- filter(Trips_2021_2022,ride_length > 0)
#Fill the blanks with NA and filter out rows with NA
Trips_2021_2022<- Trips_2021_2022 %>%
na_if("")
#Calculate how many NA in each columns
colSums(is.na(Trips_2021_2022))
#removing rows with NA values in any column
Trips_2021_2022 <- na.omit(Trips_2021_2022) 
#Drop the columns for id and coordinates (latitude & longitude)
Trips_2021_2022_v2 <- select(Trips_2021_2022,-c(start_station_id,end_station_id,start_lat,start_lng,end_lat,end_lng))
#Create another table for station coordinates, make sure to include ride_id for later table combination in Tableau
Stations <- select(Trips_2021_2022,c(ride_id,start_station_id,end_station_id,start_lat,start_lng,end_lat,end_lng))

#Calculate the ride_length
mean(Trips_2021_2022_v2$ride_length) #straight average (total ride length / rides)
median(Trips_2021_2022_v2$ride_length) #midpoint number in the ascending array of ride lengths
max(Trips_2021_2022_v2$ride_length) #longest ride
min(Trips_2021_2022_v2$ride_length) #shortest ride
#Compare members and casual users
aggregate(Trips_2021_2022_v2$ride_length ~ Trips_2021_2022_v2$member_casual, FUN = mean)
aggregate(Trips_2021_2022_v2$ride_length ~ Trips_2021_2022_v2$member_casual, FUN = median)
aggregate(Trips_2021_2022_v2$ride_length ~ Trips_2021_2022_v2$member_casual, FUN = max)
aggregate(Trips_2021_2022_v2$ride_length ~ Trips_2021_2022_v2$member_casual, FUN = min)
#See the average ride time by each day for members vs casual users
aggregate(Trips_2021_2022_v2$ride_length ~ Trips_2021_2022_v2$member_casual + Trips_2021_2022_v2$day_of_week, FUN = mean)
#Analyse the number of rides by weekday
Trips_2021_2022_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
  ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts
#Visualize the number of rides by rider type
Trips_2021_2022_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + labs(title='Number of rides by rider type') 
#Visualize the average duration
Trips_2021_2022_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") + labs(title='Average duration') 