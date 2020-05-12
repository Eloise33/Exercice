### cf doc J. Moeys 09/2018
### The soil texture wizard: R functions for plotting, classifying, transforming and exploring soil texture data

#################### packages
install.packages(tidyverse)
library(tidyverse)
install.packages( pkgs = "soiltexture" )
library( soiltexture)


############################### importation/préparation des données
setwd("D:/0Hugues/0_Csopra/R_workspace_csopra")
repcsopra<- ("D:/0Hugues/0_Csopra/")

data<- read.csv2(paste("Texture_sol.csv",sep=""),header=T)

nvar=length(data)
data[,2:nvar] <- apply(data[,2:nvar], 2, as.numeric)
rownames(data)<-data$ID.soil

text <- data %>% select(ID.soil,Argile,Limon,Sable,C.Org)


######### les données doivent se nommer CLAY, SILT et SAND
names(text)[2] <- "CLAY"
names(text)[3] <- "SILT"
names(text)[4] <- "SAND"
names(text)[5] <- "OC"


############################### Texture

######### test du jeu de données pour savoir si la somme de clay+silt+sand=100
TT.data.test( tri.data = text)

######### transformation des données pour que clay+silt+sand=100
res <- TT.normalise.sum( tri.data = text )table(text)

######### triangle de l'Aisne
TT.plot(class.sys = "FR.AISNE.TT")


######### triangle de l'Aisne avec données
TT.plot(class.sys = "FR.AISNE.TT",tri.data = res,main = "Soil texture data")

#Code couleur

code_couleur<-colors()[c(72, 72, 72, 72, 72, 72, 142,633,31,640,503,30,257,116,33,135)]
palette()

###Triangle de l'Aisne avec taille des points selon teneur et C organique

OC <- text %>% select(OC)
res <- bind_cols(res,OC)
row.names(res)<-data$ID.soil
ID <- text %>% select(ID.soil)
res <- bind_cols(res, ID)
geo <- TT.plot(class.sys = "FR.AISNE.TT",tri.data = res, z.name ="OC",main = "Soil texture triangle and organic Carbon bubble plot",grid.show = FALSE, col= "plum1", z.col.hue = 0.2, frame.bg.col = "turquoise4",class.lab.col="grey90", z.pch = 21)

###Legende
# Recompute some internal values:
z.cex.range <- TT.get("z.cex.range")
def.pch <- par("pch")
def.col <- par("col")
def.cex <- TT.get("cex")
oc.str <- TT.str(
  res[,"OC"],
  z.cex.range[1],
  z.cex.range[2]
) #

# The legend: 
legend( x = 80, y = 90, title = expression( bold('OC [g.kg'^-1 ~ ']') ),
        legend = formatC( c( min( my.text[,"OC"] ), quantile(my.text[,"OC"] ,probs=c(25,50,75)/100), max( my.text[,"OC"] ) ), format = "f", digits = 1, width = 4, flag = "0" ), # pt.lwd = 4, col = def.col, pt.cex = c( min( oc.str ), quantile(oc.str ,probs=c(25,50,75)/100), max( oc.str ) ), #, pch = def.pch, bty = "o", bg = NA, #box.col = NA, # Uncomment this to remove the legend box text.col = "black", cex = def.cex ) #
        
        
        
        
        

legend("topright", legend = data$ID.soil, col = ("blue"), pch = 15, bty = "n", pt.cex = 2, cex = 0.8, text.col = "forestgreen", horiz = TRUE, inset = c(0.1, 0.1))

legend("topright",legend = data$ID.soil, col=code_couleur, pch = 15, cex = 0.9, ncol=3, text.font = 2)


######### triangle de l'Aisne avec données représentées par une lettre

## définition des codes (lettres)
labelz <- letters[1:dim(res)[1]]
labelz

## triangle avec lettres
geo <- TT.plot(
  class.sys = "FR.AISNE.TT")
TT.text(tri.data = res,geo=geo,labels = data$ID.soil,font = 1, col = "red", adj =c(1,1) )


######### exporter la classification en tableau
classif_aisne <- TT.points.in.classes(
  tri.data = res,
  class.sys = "FR.AISNE.TT")

aisne <- as.data.frame(classif_aisne)
texture <- bind_cols(text,aisne)

write_excel_csv(texture,paste("Texture.csv",sep=""), delim = ";", na = "")


######### autres types de triangle des textures 
######### remplacer "FR.AISNE.TT" par "HYPRES.TT" ou "FR.GEPPA.TT" etc...


