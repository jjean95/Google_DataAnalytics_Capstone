# Google Data Analytics Capstone Projects
This is a repo for Google Data Analytics Certificate Capstone project

## Case 1: Cyclistic
Analyze bike sharing data to find insights

### Tasks include:
* Data collection - Collecting 12 months data from given file link
* Data cleaning - Cleaning data using R & Spreadsheet
* Data wrangling - Data wrangling in R
* Data analysis - Get insights from the clean data using R
* Data visualization - Using Tableau to visualize data

### Skills learned:

#### Spreadsheets

* Create a column called `ride_length` -- subtracting `started_at` from `ended_at` column, format as `HH:MM:SS`
* Create a column called `day_of_week` -- using `WEEKDAY` command, format as `GENERAL`
* Calculate the mean of `ride_length`
* Calculate the max `ride_length`
* Calculate the mode of `day_of_week`
* Create a pivot table for:
* - average `ride_length` for members and casual riders (rows: `member_casual`; values: average of `ride_length`)
* - average `ride_length` for users by `day_of_week` (columns: `day_of_week`; rows: `member_casual`; values: average of `ride_length`)
* - number of rides for users by `day_of_week` (columns: `day_of_week`; rows: `member_casual`; values: count of `trip_id`)

#### SQL

* Upload data to BigQuery
* Select 10 rows of data -- ```SELECT * FROM table LIMIT 10```
* Sort data according to column_name (accending order) -- ```SELECT * FROM table ORDER BY column_name```
* Insert new values into the table -- ```INSERT INTO table (column_1, column_2) VALUES (value1, value2)```
* Update a value -- ```UPDATE table SET column_1 = 'value1' WHERE column_2 = 1234 ```
* Create new table if not exist -- ```CREATE table IF NOT EXISTS```
* Change the column value type from string to float -- ```CAST(column_1 AS FLOAT)```
* Add two text strings together -- ```CONCAT(column_1, column_2)```
* Return non-null value in a list -- ```COALESCE(column_1, column_2)```
* Return the length of a string of text by counting the number of characters it contains -- ```LENGTH()/LEN()```
* Return a limited number of characters to create substrings from longer strings of text -- ```SUBSTR()```
* Remove leading, trailing, and repeated spaces in data -- ```TRIM()```

#### R

* Import libraries - `library(package)`
  * - `dplyr` - data manipulation library
  * - `tidyr` - cleaning and tidying the data
  * - `skimr` - provide summary statistics about variables in data frames
  * - `janitor` - expedite the initial data exploration and cleaning
  * - `lubridate` - working with date time data
  * - `ggplot2` - data visualization library
* Top 6 rows of data - `head(file)`
* Bottom 6 rows of data - `tail(file)`
* Look at structure of data - `str(file)`
* Merge into single csv - `big_file <- rbind(table_1,table_2)`
* Calculate time difference - `column <- difftime(column_1, column_2)`
* Format date as day_of_week column - `table$day_of_week <- format(as.Date(table$column_1), "%A")`
* Filter the data - `filter(table, column criteria)`
* Fill the blanks with NA - `na_if("")`

#### Tableau (Data visualization)

* create dashboards
* create storyboard - type of users, trends, map

[Link to Kaggle notebook](https://www.kaggle.com/code/jjean95/google-data-analytic-capstone-cyclistic)

[Link to Tableau](https://public.tableau.com/views/Capstoneproject1CyclisticDataset/Story1?:language=en-US&:display_count=n&:origin=viz_share_link)


## Case 2: Bellabeat
Analyze health sharing data to find insights
