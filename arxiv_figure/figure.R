library(plyr)
library(reshape2)
library(ggplot2)
library(RColorBrewer)
# setwd('~/Desktop/Outbox/article_preprint/arxiv_figure/')
# year,astronomy_and_astrophysics biology computer_science condensed_matter finance high-energy_physics mathematics other_physics statistics TOTAL
yearly <- read.csv('submissions_by_area_by_year_to_2011.dat', header = F)
yearly <- yearly[, -ncol(yearly)]
names(yearly) <- c("year","Astronomy and Astrophysics","astronomy_and_astrophysics_percent","Biology","biology_percent","Computer Science","computer_science_percent","Condensed Matter","condensed_matter_percent","Finance","finance_percent","High-energy Physics","high-energy_physics_percent","Mathematics","mathematics_percent","Other Physics","other_physics_percent","Statistics", "statistics_percent")

# --------------------------------------------------------
# Plotting the non-normalized version
#
cleaned_df <- melt(yearly[, c("year",names(yearly)[!grepl("percent", names(yearly))])], id.vars=1)
# Remove year.1
cleaned_df <- cleaned_df[cleaned_df$variable!="year.1",]

# reordering factors
cleaned_df$variable <-  factor(cleaned_df$variable, levels = c("Astronomy and Astrophysics", "Condensed Matter", "Mathematics", "High-energy Physics", "Other Physics", "Computer Science", "Statistics", "Finance", "Biology"))

# This makes the biology line dashed
cleaned_df$shape <- as.factor(ifelse(grepl("Biology", cleaned_df$variable), 3, 1))
# This is the color palette. We can change this. see ?brewer.pal for more options
pcolor <- rev(c(brewer.pal(9, "YlGnBu")))
# Changing "Biology" to red so it stands out.
pcolor[9] <- "#d53d4e"

figure_2 <-  ggplot(cleaned_df[complete.cases(cleaned_df),], aes(year, value, group = variable,color = variable)) + geom_point(size = 2) + geom_line(aes(linetype = shape), size = 1, show_guide = FALSE) + expand_limits(0,0) + labs(y="Percent of submissions", x="Year") + ggtitle("arXiv submissions by discipline") + guides(colour = guide_legend(title = "Disciplines", title.hjust = 0.5, keywidth = 1, keyheight = 1, override.aes = list(size = 4))) + scale_color_manual(values = pcolor,  name = "Discipline") + theme_gray()

ggsave(figure_2, file = "figure_2.png", width = 6, height = 4)
