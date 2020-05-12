library("ggplot2")  # Visualisation des données
library("dplyr")  

library(extrafont)

loadfonts(device="win")


Canada <- data.frame(Country = c("blé", "Mais", "orge", "colza"), 
                     values = c(.12, .03, .06, .09))


Canada$Country <- factor(Canada$Country, levels = rev(Canada$Country))


ggplot(data = Canada, mapping = aes(x = factor(1), y = values, fill = Country)) +
  geom_bar(width=1, stat = "identity") +
  coord_polar(theta = "y") + 
  scale_fill_brewer(type = "seq",direction = -1, palette= "YlGnBu", guide = F) +
  geom_text(aes(x = c(1.3, 1.5, 1.3, 1.3), 
                y = values/2 + c(0, cumsum(values)[-length(values)]), 
                label=paste(Country,"\n",values*100, "%")), family = "Consolas")