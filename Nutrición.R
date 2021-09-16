#Carga de los datos de nacimiento
library(readr)
df <- read_csv("C:/Users/yheli/Downloads/nacimientos.csv")
View(df)
#Cantidad de nacimiento por municipios
install.packages("tidyverse")  
library(tidiyverse)
library(plyr)
nn<-df %>% 
  group_by(df$COD_MUNIC) %>% 
  tally()
df$bajo<-0
for (i in 1:length(df$COD_MUNIC)){
  if(df$PESO_NAC[i]<4){
    df$bajo[i]=1
  }
}
nbp<-df %>% 
  group_by(df$COD_MUNIC) %>% 
  sum(df$bajo)
nbp<-aggregate(df$bajo, by=list(Category=df$COD_MUNIC), FUN=sum)
ibp<-as.data.frame(nbp$x/nn$n)           
nbp<-cbind(nbp,ibp)
library(rgdal)
shape<-readOGR(dsn="C:/Users/yheli/Downloads/Shape Municipio",layer="mpio")
plot(shape)
View(shape@data)
shape@data<-merge(x=shape@data, y=nbp, by="MPIO", all.x=TRUE)
spplot(shape, "ibp")
