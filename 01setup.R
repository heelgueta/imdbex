options(max.print=999999)

# Install and load the readr package
#install.packages("readr")


#load bigdata sets, merge them, then only focus on movies
#titler <- readr::read_tsv("title.ratings.tsv.gz")
#titleb <- readr::read_tsv("title.basics.tsv.gz") #3gb ish
#titleb <- titleb[titleb$titleType=="movie",] 
#titleb <- titleb[titleb$isAdult==0,]
#titleb <- titleb[,c(1,3,4,6,8,9)]
#movies <- merge(titleb, titler, by = "tconst", all.x = TRUE)
#rm(titleb,titler)
#write.csv(movies, "movies.csv", row.names = FALSE) # Save the merged data frame as a CSV file
movies <- read.csv("movies.csv") # from here we can refer to this smaller df

movies$averageRating <- as.numeric(movies$averageRating)
movies$numVotes <- as.numeric(movies$numVotes)
movies$startYear <- as.numeric(movies$startYear)
movies$averageRating <- as.numeric(movies$averageRating)
movies <- movies[!is.na(movies$averageRating) & !is.na(movies$numVotes) & !is.na(movies$startYear), ]


#head(movies);str(movies)

#hist(movies$averageRating) #neat bell curve ish
#hist(scale(log10(log10(log10(log10(log10(log10(movies$numVotes+1)+1)+1)+1)+1)+1)))

# Quantile transformation function
quantile_transform <- function(x) {
  rank_x <- rank(x, ties.method = "average")
  scaled_rank <- (rank_x - 1) / (length(rank_x) - 1) * 100
  return(scaled_rank)
}

# Apply the quantile transformation to movies$numVotes
movies$quantile_numVotes <- quantile_transform(movies$numVotes)
#hist(movies$quantile_numVotes)

# Display the first few rows of the data frame
#head(movies)

rm(list = setdiff(ls(), "movies"))
