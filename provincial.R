library(dplyr)

votedata <- read.csv("FullReporting_ECT_20190328_District_level_EN.csv")
parties <- as.list(levels(votedata$Party))
# provinces <- as.list(levels(votedata$Province))

provincepop <- votedata %>%
    group_by(Province) %>%
    summarise(SumVotes = sum(Votes))

provincevotes <- votedata %>%
    group_by(Province, Party) %>%
    summarise(SumVotes = sum(Votes))

provincevotespercent <- merge(provincepop, provincevotes, by = "Province")
provincevotespercent$SumVotes.y <- 100*provincevotespercent$SumVotes.y/provincevotespercent$SumVotes.x
provincevotespercent$SumVotes.x <- NULL
colnames(provincevotespercent) <- c("Province", "Party", "Percent")