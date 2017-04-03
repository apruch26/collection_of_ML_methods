#Read in Data, Trim data, Remove all NA's 
dating<-read.csv('Speed Dating Data.csv')
dating<-dating[,c('dec','attr','sinc','intel','fun','amb','shar','like')]
dating$dec<-factor(dating$dec,levels=c(0,1))
dating<-na.omit(dating)

#Create Test + Train Set
set.seed(1)
indices<-sample(7017,3508)
train<-dating[indices,]
test<-dating[-indices,]

#glm -- Saved in a variable fit to run predict function on
#fit<-glm(dec~attr+sinc+intel+fun+amb+shar,data=train,family='binomial')
# dec~. means include every predictor # we used dec~.-like because we wanted to include everything except like
fit<-glm(dec~.-like,data=train,family='binomial')

#predict function (returns probabilities) + Added probabilities column
test$probabilities<-predict(fit,newdata=test,type='response')

#Saw which probabilities were greater than 0.5 and added a Classfication Column 
test$classification<-as.numeric(test$probabilities>=0.5)

#See how many we classified correctly
length(which(test$dec==test$classification))/dim(test)[1]
