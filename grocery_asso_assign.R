grocery=read.csv(file.choose())
View(grocery)
str(grocery)
# converting everything into character format 
grocery[]=lapply(grocery,as.character)
View(grocery)
# Creating a custom fucntion to collapse all the items in a transaction into a single sentence 
paste_fun = function(i){
  return(paste(as.character(i),collapse = " "))
}

# Applying the custom function
grocery["new_col"]=apply(grocery,1,paste_fun)
View(grocery)

install.packages("tm")
# tm package is used to do text manipulation and forming DTM and TDM matrices
library(tm)
x=Corpus(VectorSource(grocery$new_col))# Selecting the new column which
# contains all items of a transaction in a single sentence
x=tm_map(x,stripWhitespace)
#Creating tdm matrix
tdm=t(TermDocumentMatrix(x))
# Converting TDM matrix to data frame
df=data.frame(as.matrix(tdm))
View(df)

#Association Rules
library(arules)
library(arulesViz)
#Apriori algorithm
#ar=apriori(df,parameter=list(support=0.02,confidence=0.5,minlen=2))
ar=apriori(as.matrix(df),parameter = list(support=0.02,confidence=0.5,minlen=2))
ar1=apriori(as.matrix(df),parameter = list(support=0.02,confidence=0.8,minlen=2))
ar2=apriori(as.matrix(df),parameter = list(support=0.02,confidence=0.8,minlen=3)) 
ar2
inspect(head(sort(ar1,by="lift")))
plot(ar)
plot(ar,method = "group")
plot(ar,method = "graph")
