movies=read.csv(file.choose())
View(movies)
str(movies)
library(arules)
library(arulesViz)
#Apriori
we=apriori(as.matrix(movies[,(6:15)]),parameter = list(support=0.02,confidence=0.7,minlen=2))
we1=apriori(as.matrix(movies[,(6:15)]),parameter = list(support=0.05,confidence=0.9,minlen=3))
we
inspect(head(sort(we,by="lift")))          
plot(we,method="group")
plot(we,method="graph")
