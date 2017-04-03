#Read in Movie Data, Pair it down to: gross, content_rating, movie_facebook_likes
movie<-read.csv('movie_metadata.csv')
data<-movie[c('gross','content_rating','movie_facebook_likes')]

#Omit any records with an NA in it
data<-na.omit(data)

#Filtering out all Ratings we don't want
data<-data%>%
  filter(content_rating=='G'|content_rating=='PG'|content_rating=='PG-13'|content_rating=='R')

#Add a new column - Audience - with two factors: younger(positive)(G or PG) and older (negative)(PG-13 or R)
data$Audience<-'younger'
indices<-which(data$content_rating=='PG-13'|data$content_rating=='R')
data$Audience[indices]<-'older'
data$Audience<-factor(data$Audience,levels=c('younger','older'))

#ROC curves and finding optimal threshold
curve<-roc(Audience~gross,data=data,plot=TRUE,smooth=TRUE)
coords(curve,x='best') # specificity = 0.5883894 sensitivity = 0.5988258
curve<-roc(Audience~gross,data=data,plot=TRUE)
curve$specificities # curve$specificities @ [1619]
curve$thresholds[1619] # best threshold is gross of 35392780



