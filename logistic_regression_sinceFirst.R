#Read in Data
train<-read.csv('train.csv')

#Trim Data into new DataSet & Change Factor to correct order for glm
train<-train[c('sinceFirst','madeDonation')]
train$madeDonation<-factor(train$madeDonation,levels=c(1,0))

#Fitting Generalized Linear Models
glm(madeDonation~sinceFirst,data=train,family='binomial')

#Logistic Regression
f<-function(x){
  1/(1+exp(1.089582+0.001937*x))
}

#Bring in test data
test<-read.csv('test.csv')

#Run test set thru Train's Logistic Regression
f(test$sinceFirst)
test$prob<-f(test$sinceFirst)

#Write to csv file
write.csv(test,'submission_sinceFirst.csv',row.names=FALSE)
