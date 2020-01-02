library(dplyr)
library(maps)
library(mapdata)
library(sp)

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

# make map
# this code makes inaccurate maps, ignore it.
# also the province names and those from gadm have different spelling, so that
# might contribute to the error

gadm <- readRDS("gadm36_THA_1_sp.rds")
shadesofgrey <- colorRampPalette(c("grey100", "grey0"))
colours <- shadesofgrey(100)
pt <- provincevotespercent[provincevotespercent$Party == "Bhumjaithai Party",]
#regions <- pt$Province
votepercents <- pt$Percent
plot(gadm, border = 'darkgrey', col = colours[votepercents])