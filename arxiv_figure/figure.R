library(plyr)
library(reshape2)
library(ggplot2)
library(RColorBrewer)
# setwd('~/Desktop/Outbox/article_preprint/arxiv_figure/')
# year,astronomy_and_astrophysics biology computer_science condensed_matter finance high-energy_physics mathematics other_physics statistics TOTAL
foo <- read.csv('submissions_by_area_by_year_to_2011.dat', header = F)
foo <- foo[, -ncol(foo)]
names(foo) <- c("year","Astronomy and Astrophysics","astronomy_and_astrophysics_percent","Biology","biology_percent","Computer Science","computer_science_percent","Condensed Matter","condensed_matter_percent","Finance","finance_percent","High-energy Physics","high-energy_physics_percent","Mathematics","mathematics_percent","Other Physics","other_physics_percent","Statistics", "statistics_percent")

# --------------------------------------------------------
# Plotting the non-normalized version
#
foo3 <- melt(foo[, c("year",names(foo)[!grepl("percent", names(foo))])], id.vars=1)
# Remove year.1
foo3 <- foo3[foo3$variable!="year.1",]

foo3$variable <-  factor(foo3$variable, levels = c("Astronomy and Astrophysics", "Condensed Matter", "Mathematics", "High-energy Physics", "Other Physics", "Computer Science", "Statistics", "Finance", "Biology"))

foo3$shape <- as.factor(ifelse(grepl("Biology", foo3$variable), 2, 1))
pcolor <- rev(c(brewer.pal(9, "YlGnBu")))
pcolor[9] <- "#d53d4e"
figure_2 <- ggplot(foo3[complete.cases(foo3),], aes(year, value, group = variable,color = variable)) + geom_line() + geom_line(aes(linetype = shape), size = 1.3, , show_guide = FALSE) + expand_limits(0,0) + labs(y="Percent of submissions", x="Year") + ggtitle("arXiv submissions by discipline") + guides(colour = guide_legend(title = "Disciplines", title.hjust = 0.5, keywidth = 1)) + scale_color_manual(values = pcolor,  name = "Discipline") + theme_gray()

ggsave(figure_2, file = "figure_2.png", width = 6, height = 4)
