# Netflix Movies and Tv shows analysis using SQL

  ![Netflix logo](netflix_logo.png)

##Overview

This project aims to analyze Netflix data using SQL.
The main objective is to extract valuable insights such as customer ratio in movies:tv shows, trending actors and etc. The following README consists of business problem,their solutions,data and conclusions

##Objective

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.


##Dataset


[Dataset link](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

**Structure of the table in MYSQL

CREATE TABLE IF NOT EXISTS netflix(

show_id VARCHAR(6) PRIMARY KEY,

show_type VARCHAR(10),

title	VARCHAR(150),

director VARCHAR(200),

cast VARCHAR(255),

country	VARCHAR(200),

date_added	VARCHAR(100),

release_year INT,

rating VARCHAR(100),

duration VARCHAR(50),

listed_in	VARCHAR(255),

show_description VARCHAR(200)

);


Use the following line of query to download the dataset in mysql

SET GLOBAL local_infile=1;

load data local infile "//filepath//"
into table netflix
fields terminated by ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows;


#Note: 

Add OPT_LOCAL_INFILE=1 in the edit connection(advance section)


