
# Exploratory Data Analysis for Udemy
## Overview
The EDA(Exploratory Data Analysis) for Udemy project focuses on analyzing a dataset of Udemy courses to uncover patterns and trends. Through data cleaning, visualization, and insight generation, it explores key aspects like course ratings, pricing, and categories. This analysis helps in making informed decisions about course offerings and pricing strategies.
## Objectives
- Clean the dataset by handling missing values and outliers, ensuring data quality for accurate analysis.
- Explore pricing strategies and trends to understand how course prices vary based on ratings and content type
- Visualize relationships between course duration, ratings, and pricing to uncover key factors affecting course success.
- Generate insights on the most popular course categories, helping course creators make informed decisions.
## Dataset
The dataset used for this project can be found at Kaggle
- Dataset Link : [Udemy Course](https://www.kaggle.com/datasets/refiaozturk/udemy-courses-dataset)
## Code Explaination
- **Data Loading**: The dataset is loaded using pandas.read_csv(), allowing easy manipulation and analysis of the data.
- **Data Cleaning**: Missing values are handled using dropna() or fillna(), ensuring the dataset is ready for analysis.
- **Exploratory Data Analysis**: Perform initial analysis to identify trends, distributions, and outliers.
- **Data Visualization**: Various plots (piecharts, bar charts) are created with Matplotlib and Seaborn to analyze trends like ratings and prices.
- **Insight Generation**: Key insights, such as average course price by category, are derived through aggregation and statistical functions.
## Visualization
![bar_chart](https://github.com/user-attachments/assets/4b1f68b5-9d75-4e79-885b-47e14c218188)
- **Top Performers**: Displays the top 5 courses with the highest ratings, emphasizing user preferences and quality benchmarks.
- **Ratings Range**: Highlights that all selected courses have ratings above 4.5, showcasing consistent excellence.
- **Category Insights**: Reveals the distribution of highly rated courses across various categories, indicating popular topics.
- **Actionable Insight**: Guides course creators to focus on characteristics of top-rated courses for future offerings.
![line](https://github.com/user-attachments/assets/1a17963f-6b8e-4231-a764-265dbbe7776e)
- **Sales Trends and Growth**: The average sales per year chart shows trends in course popularity, highlighting years of growth or decline.
- **Course Frequency**: The number of courses per year chart indicates how the course offerings evolved over time, suggesting potential market saturation.
- **Actionable Insights**: Both charts provide insights into which years had the highest performance, helping guide decisions on content creation and marketing strategies.
  
![scatter](https://github.com/user-attachments/assets/463218f2-8a0b-409f-a421-8a4b5d87e2ec)
- **Price vs Rating**: The scatter plot shows the relationship between course prices and ratings, helping identify pricing trends.
- **Clustering**: Reveals whether high-rated courses tend to have higher or lower prices, or if ratings are spread across all price ranges.
- **Trend Identification**: Helps detect patterns or correlations between pricing strategies and course ratings for better decision-making.
![pie](https://github.com/user-attachments/assets/5888bd0c-3397-4270-a4a4-281551e3b3a7)
- **Category Distribution**: The pie chart visualizes the percentage distribution of courses across different categories, showing the most popular areas.
- **Course Popularity**: Reveals where courses are most concentrated, guiding content creators to focus on trending areas.
- **Market Share**: Offers an overview of how the Udemy marketplace is segmented by course categories, helping in strategic planning.
![hm](https://github.com/user-attachments/assets/9fec2fdc-aa34-4abe-801d-b5d0e00982f5)
- **Correlation Insights**: The heatmap shows correlations between different features (e.g., course rating, price, duration), helping to identify relationships.
- **Feature Relationships**: Helps in understanding how features interact, like whether longer courses tend to have higher ratings.
- **Actionable Insights**: Provides a visual summary of feature interdependencies, guiding data-driven decisions for course development.
![box](https://github.com/user-attachments/assets/2fc00412-7345-448b-b84e-866548fe84ee)
- **Price Distribution**: The boxplot shows the distribution of course prices across categories, highlighting the range and outliers.
- **Price Variation**: It visually indicates the spread of course prices, helping to identify if some categories have extreme values.
- **Median Comparison**: The line inside the box represents the median price, showing the central tendency of course prices.
- **Outliers**: Any points outside the whiskers are outliers, potentially indicating niche or premium courses.
## Conclusion
This project successfully explored key aspects of Udemy courses, focusing on ratings, pricing, and category distribution. The analysis revealed important insights, such as the relationship between course price and ratings, as well as trends in course offerings. Visualizations like bar charts, scatter plots, and heatmaps enhanced the understanding of the data. These findings provide actionable recommendations for content creators and marketers to optimize course strategies. Future analyses could incorporate advanced predictive models or deeper segmentation for more tailored insights.
## References
#### Dataset: Udemy Courses Dataset created and curated by Swetha.
#### Tools & Libraries Used:
- Python Libraries: Pandas, Matplotlib, Seaborn, NumPy
- Jupyter Notebooks for interactive analysis
  

