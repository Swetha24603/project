# Amazon Kindle Book Dataset with Python
## Overview
This project demonstrates an end-to-end data analytics workflow using the Amazon Kindle Books Dataset 2023. The dataset contains detailed information about 130K books, including titles, authors, prices, ratings, and categories.
The goal is to analyze the dataset, extract insights, and present them visually using Power BI. The project involves:

* **Data Collection and Exploration**: Cleaning, transforming, and analyzing data using Python.
* **Database Integration**: Storing cleaned data in a PostgreSQL database for structured querying.
* **Data Visualization**: Creating an interactive dashboard in Power BI to showcase key insights.

## Objective
* **Data Exploration**: Understand the dataset by performing exploratory data analysis (EDA) to identify trends, patterns, and anomalies.
* **Data Cleaning**: Handle missing values, duplicates, and inconsistencies in the dataset.
* **Feature Engineering**: Create new features or modify existing ones to improve data quality and insight extraction.
* **Data Visualization**: Generate meaningful plots and graphs to visualize key metrics and trends.

## Dataset
The dataset used for this project can be found at Kaggle
* Dataset Link :[Amazon Kindle](https://www.kaggle.com/datasets/asaniczka/amazon-kindle-books-dataset-2023-130k-books)

## Code Explaination
* **Data Loading**: Likely involves loading the dataset into a pandas DataFrame using pd.read_csv().
* **Data Exploration**: Inspecting the dataset's structure, identifying missing data, and calculating basic statistics.
* **Cleaning and Transformation**: Handling missing values, creating new columns, and filtering or aggregating data for insights.
* **Visualization**: Using matplotlib or seaborn to create visualizations like histograms, bar plots, and line chart.
* **Database Integration**: Preparing and inserting cleaned data into PostgreSQL for further analysis.

### Importing Libraries
```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```
* **pandas**: Used to load, manipulate, and analyze data in tabular form (DataFrame).
* **numpy**: Provides mathematical functions to work with arrays and numerical computations.
* **matplotlib**: A plotting library used to create static, animated, and interactive visualizations.
* **seaborn**: Built on top of matplotlib, it simplifies the process of creating attractive and informative statistical graphics.
###  Installing PostgreSQL Adapter
```
!pip install psycopg2-binary
```
* Install the psycopg2-binary library to interact with a PostgreSQL database.
### Setting Up SQLAlchemy
```
from sqlalchemy import create_engine
import json
```
* **create_engine**: A function from the SQLAlchemy library to establish a connection with a database. It acts as a bridge between Python and databases like PostgreSQL.
* **json**: A library to handle JSON files, often used for reading configurations like database credentials.
### Loading the Dataset
```
df = pd.read_csv('kindle_data-v2.csv')
df.head()
```
* **pd.read_csv**: Reads the CSV file into a DataFrame.
* **data.head()**: Displays the first 5 rows of the dataset for an initial preview.
### Data Cleaning and Exploration
```
null_values = df.isnull().sum()
null_val = null_values[null_values > 1]

df_null = pd.DataFrame({
    'Column': null_val.index,
    'Null Percentage' : (null_val.values/len(df))*100
})
print(df_null)
```
* **isnull().sum()**: Identifies columns with missing data and the number of missing values.
```
df['publishedDate'].fillna("Unkown",inplace = True)
df['soldBy'].fillna('Unkown',inplace = True)
df.dropna(subset = 'author',inplace = True)
df['publishedDate'] = df['publishedDate'] .replace('Unkown',pd.NaT)
df['publishedDate'] = pd.to_datetime(df['publishedDate'],errors = 'coerce')
```
* **df['published_year'] = df['publishedDate'].dt.year**: Extracts the year from publishedDate and creates a new column published_year.
* **df['published_year'] = df['published_year'].fillna(0).astype(int)**: Replaces missing values in published_year with 0 and converts the column to integer type.
* **df['published_month'] = df['publishedDate'].dt.month**: Extracts the month from publishedDate and creates a new column published_month.
* **df['published_month'] = df['published_month'].fillna(0).astype(int)**: Replaces missing values in published_month with 0 and converts the column to integer type.
* **dropna()**: Removes rows with missing data to ensure data quality.
```
df.drop(columns = ['imgUrl','productURL'],inplace=True)
```

### Data Visualization
```
sns.histplot(x='stars',data=df,kde=True,bins=17)
plt.title('Distribution of Stars')
plt.xlabel('Rating')
plt.ylabel('Frequency')
plt.show()
```
![Untitled](https://github.com/user-attachments/assets/9661a64d-662f-477f-b76a-72c67624a40c)
* **sns.histplot**: Creates a histogram with an optional Kernel Density Estimate (KDE) curve.
* Adds titles and axis labels to enhance interpretability.
```
category_counts = df['category_name'].value_counts().head(10)
plt.figure(figsize=(10,5))
sns.barplot(x=category_counts.index,y=category_counts.values,palette='magma')
plt.title('Top 10 Categories')
plt.xlabel('Category name')
plt.ylabel('Count')
plt.xticks(rotation=60,ha='right')
plt.show()
```
![Untitled1](https://github.com/user-attachments/assets/510736b5-016f-45e1-84fe-6c9fc30dfae1)
* **sns.barplot**(x=category_counts.index, y=category_counts.values, palette='magma'): Creates a bar plot with categories on the x-axis and their counts on the y-axis, using the 'magma' color palette.
 ```
year_price = df.groupby('published_year')['stars'].mean().reset_index()
year_price = year_price.sort_values(by='published_year',ascending=False).head()
year_price['published_year'] = year_price['published_year'].round().astype(int)
plt.plot(year_price['published_year'],year_price['stars'],marker='o',linestyle='--',color='teal')
plt.title('Average book rating per Year')
plt.xlabel('Year')
plt.ylabel('Average Rating')
plt.xticks(year_price['published_year'])
plt.show()
```
![Untitled2](https://github.com/user-attachments/assets/9985d993-24e0-4358-a65e-2e622b5e0a48)
* Groups data by published_year, calculates the mean rating, and visualizes the top 5 years with a line plot, highlighting trends in average ratings.
### Connecting to Postgresql
```
engine = create_engine(f'postgresql+psycopg2://{username}:{password}@{host}:{port_id}/{database_name}')
```
* **create_engine**: Defines the connection string for the database.

