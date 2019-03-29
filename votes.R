votedata <- read.csv("FullReporting_ECT_20190328_District_level_EN.csv")
parties <- as.list(levels(votedata$Party))
votes <- lapply(parties, function(ii) sum(votedata[votedata$Party == ii,]$Votes))
result <- data.frame(unlist(parties), unlist(votes))
colnames(result) <- c("Party", "Votes")
result <- result[order(-result$Votes),]