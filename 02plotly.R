library(plotly)

# Assuming your DataFrame is named 'movies' and you have already created the 'main_genre' column
top_movies <- movies[movies$numVotes > 100000, ]

# Normalize the number of votes for sizing the dots
top_movies$votes_normalized <- scales::rescale(top_movies$numVotes, to = c(5, 30))

plot_ly(
  data = top_movies,
  x = ~jitter(startYear, amount = 0.5),  # Add jitter to the year values
  y = ~averageRating,
  text = ~paste(
    "Title: ", primaryTitle, "<br>",
    "Year: ", startYear, "<br>",
    "Rating: ", averageRating, "<br>",
    "Votes: ", numVotes
  ),
  type = "scatter",
  mode = "markers",
  marker = list(
    size = ~votes_normalized,
    color = ~averageRating,
    colorscale = "Viridis",
    reversescale = TRUE,
    opacity = 0.7,
    showscale = FALSE,
    colorbar = list(title = "Average Rating"),
    line = list(width = 0)  # Remove the outline from the dots
  ),
  hoverinfo = "text"
) %>%
  layout(
    title = "Movies with More Than X Votes",
    xaxis = list(title = "Year"),
    yaxis = list(title = "Average Rating")
  )
