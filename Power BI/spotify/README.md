# Spotify Music Dashboard

![spotify](https://github.com/user-attachments/assets/65eb874d-a0c4-4afe-96c5-23bf640813e3)

## Overview
The Spotify Dashboard provides an interactive, data-driven overview of the streaming platform’s user engagement, listening trends, and song popularity. It aims to deliver actionable insights into user behavior, song performance, and overall platform growth over a period of time.

## Objectives
- Analyze Song Popularity Over Time :
   - Track and visualize the most popular songs based on metrics like play count and popularity score over a specified period (e.g., monthly, yearly).
   - Identify trends in the rise and fall of song popularity to understand what drives music engagement.
     
- Explore Genre Trends:
   - Analyze the distribution of songs across different genres, identifying which genres are gaining popularity and which are declining.
   - Provide insights into the evolution of music preferences and genre dominance over time.

- Identify Top Artists and Songs:
   - Highlight the top-performing artists and their most popular songs.
   - Rank songs by popularity or other metrics to showcase the most successful artists and tracks on the platform.
- Measure User Engagement by Geography:
   - Explore how music preferences vary by region, identifying the most popular genres, songs, and artists in different locations.
   - Highlight global or regional trends that can guide Spotify's marketing and promotional strategies.
## Dataset
- The dataset used for this project can be found at Kaggle
- Dataset Link : [Spotify](https://www.kaggle.com/datasets/joebeachcapital/30000-spotify-songs)

## Data Model
The dataset is structured to capture essential details about songs, artists, and user engagement, and is likely a flat structure with columns for song attributes, performance metrics, and user information.
- **Total Song Streams** :
   - Measure: Sum of the streams for each song, providing an overall measure of a song's performance.
   - Purpose: This calculation aggregates the total number of times a song has been streamed across all regions and time periods, allowing for comparison of song popularity.
- **Average Popularity Score**:
   - Measure: The average popularity_score for each song, calculated across different time periods or user groups.
   - Purpose: Tracks the average popularity of a song, helping to understand whether a song is consistently popular or if its popularity is fluctuating over time.
- **Top Artist by Total Streams**:
   - Measure: Sum of streams for all songs by an artist, sorted to identify the most popular artist based on total streams.
   - Purpose: Ranks artists based on their total streams, helping to determine the most influential and popular artists on the platform.
- **Genre Popularity Over Time**:
   - Measure: Aggregated streams of songs within each genre, calculated over specific time periods (e.g., monthly, quarterly).
   - Purpose: This measure shows how different genres perform over time, revealing emerging trends and shifts in genre popularity.
- **User Engagement Trends**:
   - Measure: Total listening_time or songs_listened by users, aggregated over time.
   - Purpose: Analyzes user behavior by measuring the total time spent listening to songs or the total number of songs listened to.
## Visualizations
- **Top Songs and Artists Performance** :
Display the top-performing songs and artists based on metrics like  play counts or popularity scores.
- **Genre Distribution** :
Show the distribution of songs across various genres, highlighting the most popular genres at any given time.

- **User Engagement Trends** :
Visualize user engagement patterns over time, highlighting the most-streamed songs on specific days, weeks, or months.

- **Release Date vs. Popularity**:
Compare the release dates of songs with their popularity or streams to explore how release timing impacts a song’s performance.

## Conclusion
The Spotify Dashboard delivers a detailed analysis of song performance, genre popularity. By examining metrics such as streams, popularity scores it offers valuable insights into the evolving music landscape. The dashboard's interactive features allow users to track performance over time, identify key artists . This tool is essential for understanding music trends and guiding decisions in marketing, content strategy .


