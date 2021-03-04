#setwd("C:/Users/Filipp/Documents/usd_data_sci/501_foundations_of_ds/capstone")

#clean vars
rm(list=ls())

#cld3, textcat 
require(cld3)
require(dplyr)
require(textcat) #textcat("words!")
require(qdap)

#read in data 
tweet_pop <- read.csv("train.csv",T)

#fix grammar and UTF Encoding 
tweets$text <- gsub("https\\S*", "", tweets$text) 
tweets$text <- gsub("http\\S*", "", tweets$text) 
tweets$text <- gsub("@\\S*", "", tweets$text) 
tweets$text <- gsub("amp", "", tweets$text) 
tweets$text <- gsub("[\r\n]", "", tweets$text)
tweets$text <- gsub("[[:punct:]]", "", tweets$text)
tweets$text <- iconv(tweets$text, "ASCII", "UTF-8", sub="")

#container for average results of how many tweets are "English"
av_true <- c()

#cycle through 10 samples of n=1000, aggregate findings.
for (i in 1:10){
	#random sample 
	tweets <- tweet_pop[sample(nrow(tweet_pop), 1000), ]

	#lanuage detection - we're primarily looking for english here.
	tweets$detected_language = detect_language(tweets$text)


	tweets$is_english = (tweets$detected_language=="en")
	english_count = count(tweets,tweets$is_english)
	english_count$freq = english_count$n / sum(english_count$n)
	
	#rename 
	names(english_count) = c("is_english","count","freq")
	
	#subset to frequency of english tweets. append frequency to our list.
	english_freq <- subset(english_count,english_count$is_english==TRUE)
	av_true = append(av_true,english_freq$freq)
}

#get our average english tweet frequency - or our classification rate, really.
print(mean(av_true))

#analyse char length 
#get the average tweet length by classification 
tweets$tweet_length <- nchar(tweets$text)
av_nchar <- aggregate(tweets$tweet_length, by=list(tweets$is_english), FUN=mean)
names(av_nchar) = c("english","avg_chars")

#average number of words 
tweets$word_count <- sapply(strsplit(tweets$text, " "), length)
av_words <-aggregate(tweets$word_count, by=list(tweets$is_english), FUN=mean)
av_words_n <- mean(tweets$word_count)
names(av_words) = c("english","avg_words")

print(av_nchar)
print(av_words)
print(av_words_n)

#analyze grammatical errors 
#begin by downloading an entire SCOWL dictionary from the internet (fun, right?)
dict_dir <- tempdir()
dict_url <- 'http://downloads.sourceforge.net/wordlist/scowl-2016.01.19.zip'
dict_local_zip <- file.path(dict_dir, basename(dict_url))
if (! file.exists(dict_local_zip)) {
    download.file(dict_url, dict_local_zip)
    unzip(dict_local_zip, exdir=dict_dir)
}

dict_files <- list.files(file.path(dict_dir, 'final'), full.names=TRUE)
dict_files_match <- as.numeric(tools::file_ext(dict_files)) <= 60 & grepl("english-", dict_files, fixed = TRUE)
dict_files <- dict_files[ dict_files_match ]

words <- unlist(sapply(dict_files, readLines, USE.NAMES=FALSE))

#create a function that breaks down a tweet into distinct words, sees how many are words, returns a ratio of correct:all words 
proper_word_ratio <- function(tweet){
	tweet_words <- strsplit(tweet," ")
	are_words <- tweet_words[[1]] %in% words 
	return(sum(are_words) / length(tweet_words[[1]]))
}

#correct word scoring and aggregation  
tweets$spelling_score <- sapply(tweets$text,proper_word_ratio)
av_spelling <- aggregate(tweets$spelling_score,by=list(tweets$is_english),FUN=mean)
names(av_spelling)=c("english","spelling_score")
print(av_spelling)
print(mean(tweet$spelling_score))

#word cloud creation 

#install.packages("wordcloud")
library(wordcloud)
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("wordcloud2)
library(wordcloud2)
library(tidytext)
library(tm)

#Create a vector containing only the textfor each polarity 
text <- tweets$text 
text.positive <- subset(tweets,tweets$sentiment=="positive")
text.neutral  <- subset(tweets,tweets$sentiment=="neutral")
text.negative <- subset(tweets,tweets$sentiment=="negative")

wordcloudify<-function(text,title){
	# Create a corpus, clean up, remove stop words 
	
	docs <- Corpus(VectorSource(text))
	docs <- tm_map(docs, content_transformer(tolower))
	docs <- tm_map(docs, removeWords, stopwords("english"))

	docs <- docs %>%
	  tm_map(removeNumbers) %>%
	  tm_map(removePunctuation) %>%
	  tm_map(stripWhitespace)
	docs <- tm_map(docs, content_transformer(tolower))
	docs <- tm_map(docs, removeWords, stopwords("english"))

	#create a matrix of the word and its frequency 
	dtm <- TermDocumentMatrix(docs) 
	matrix <- as.matrix(dtm) 
	words <- sort(rowSums(matrix),decreasing=TRUE) 
	df <- data.frame(word = names(words),freq=words)

	#generate the word cloud and save to jpeg
	jpeg(file=paste(title,".jpeg",sep=""))
	wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
	dev.off()
}

#create a new cloud for each category and save 
wordcloudify(text,"all_tweets")
wordcloudify(text.positive,"Word Cloud for Positive Tweets")
wordcloudify(text.neutral,"Word_Cloud_for_Neutral_Tweets")
wordcloudify(text.negative,"Word Cloud for Negative Tweets")


#iterate over tweets, save each stop word, calculate the frequency.
stop_word_list <- c()

for (i in 1:nrow(tweets)){
	tweet = tweets[i,]$text 
	tweet_words <- strsplit(tweet," ")
	stop_words <- tweet_words[[1]] %in% stopwords("english") 
	args <- cbind(tweet_words[[1]],stop_words) %>% subset(stop_words=="TRUE")
	args <- args[,1]
	stop_word_list <- append(stop_word_list,c(args))	
}

stop_word_list = stop_word_list %>% table() %>% sort(decreasing=TRUE)
stop_word_list = as.data.frame(stop_word_list)
names(stop_word_list) = c("word","frequency")
print(stop_word_list)

#save to csv
write.csv(stop_word_list,"stop_word_count.csv")

#get a stop word ratio for each tweet 
ratio_stop_words <- function(tweet){
	tweet_words <- strsplit(tweet," ")
	stop_words <- tweet_words[[1]] %in% stopwords("english") 
	return (sum(stop_words)/length(tweet_words[[1]]))
}

tweets$stop_word_ratio <- sapply(tweets$text, ratio_stop_words)
#get stop word ratios for each polarity 
swr_polarity <- aggregate(tweets$stop_word_ratio,by=list(tweets$sentiment),FUN=mean)
names(swr_polarity) = c("polarity","average ratio")
print(swr_polarity)

