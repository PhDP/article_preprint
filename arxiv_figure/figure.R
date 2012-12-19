library(plyr)
library(reshape2)
library(ggplot2)
# setwd('~/Desktop/Outbox/article_preprint/arxiv_figure/')
# year,astronomy_and_astrophysics biology computer_science condensed_matter finance high-energy_physics mathematics other_physics statistics TOTAL
foo <- read.csv('submissions_by_area_by_year_to_2011.dat', header = F)
foo <- foo[, -ncol(foo)]
names(foo) <- c("year","astronomy_and_astrophysics","astronomy_and_astrophysics_percent","biology","biology_percent","computer_science","computer_science_percent","condensed_matter","condensed_matter_percent","finance","finance_percent","high-energy_physics","high-energy_physics_percent","mathematics","mathematics_percent","other_physics","other_physics_percent","statistics", "statistics_percent")


# ------------------------------------------------------------
# Plotting the normalized version
#
# foo2 <- melt(foo[, c("year",names(foo)[grepl("percent", names(foo))])], id.vars=1)
# pcolors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#CC79A7")
# foo2$shape <- as.factor(ifelse(grepl("biology", foo2$variable), 2, 1))
# ggplot(foo2[complete.cases(foo2),], aes(year, value, group = variable)) + geom_line(aes(color = variable, linetype = shape), size = 1.1) + expand_limits(0,0) + scale_color_manual(values = pcolors, name = "Discipline") + labs(y="Percent of submissions", x="Year") + ggtitle("arXiv submissions by discipline")



# --------------------------------------------------------
# Plotting the non-normalized version
#
foo3 <- melt(foo[, c("year",names(foo)[!grepl("percent", names(foo))])], id.vars=1)
# Remove year.1
foo3 <- foo3[foo3$variable!="year.1",]

foo3$shape <- as.factor(ifelse(grepl("biology", foo3$variable), 2, 1))


pcolor  <- brewer.pal(9, "YlGnBu")

ggplot(foo3[complete.cases(foo3),], aes(year, value, group = variable,color = variable)) + geom_line() + geom_line(aes(linetype = shape), size = 1.1, , show_guide = FALSE) + expand_limits(0,0) + scale_color_manual(values = pcolor, name = "Discipline") + labs(y="Percent of submissions", x="Year") + ggtitle("arXiv submissions by discipline") + guides(colour = guide_legend(title = "Disciplines", title.hjust = 0.5)) + scale_y_discrete(labels = c("Astronomy/Astrophysics", "Biology", "Computer Science", "Condensed Matter", "Finance", "High-energy physics", "Mathematics", "Other Physics", "Statistics"))

# --------------------------------------------------------
# Nice! I'd be curious to know what the non-normalized version looks like. That would demonstrate the overall increasing trend in all disciplines, but also point out how low biology is relative to others even though it is increasing.

