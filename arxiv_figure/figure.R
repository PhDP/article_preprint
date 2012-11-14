library(plyr)
library(reshape2)
library(ggplot2)
# setwd('~/Desktop/Outbox/article_preprint/arxiv_figure/')
# year,astronomy_and_astrophysics biology computer_science condensed_matter finance high-energy_physics mathematics other_physics statistics TOTAL
foo <- read.csv('submissions_by_area_by_year_to_2011.dat', header = F)
foo <- foo[, -ncol(foo)]
names(foo) <- c("year","astronomy_and_astrophysics","astronomy_and_astrophysics_percent","biology","biology_percent","computer_science","computer_science_percent","condensed_matter","condensed_matter_percent","finance","finance_percent","high-energy_physics","high-energy_physics_percent","mathematics","mathematics_percent","other_physics","other_physics_percent","statistics", "statistics_percent")
foo2 <- melt(foo[, c("year",names(foo)[grepl("percent", names(foo))])], id.vars=1)
pcolors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#CC79A7")
foo2$shape <- as.factor(ifelse(grepl("biology", foo2$variable), 2, 1))
ggplot(foo2[complete.cases(foo2),], aes(year, value, group = variable)) + geom_line(aes(color = variable, linetype = shape), size = 1.1) + expand_limits(0,0) + scale_color_manual(values = pcolors, name = "Discipline") + labs(y="Percent of submissions", x="Year") + ggtitle("arXiv submissions by discipline") 