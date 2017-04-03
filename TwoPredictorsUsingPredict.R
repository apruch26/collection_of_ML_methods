#Read in Data
train<-read.csv('train.csv')
test<-read.csv('test.csv')

#Make factor
train$madeDonation<-factor(train$madeDonation,levels=c(0,1))

#glm
fit<-glm(madeDonation~sinceLast+number+total+sinceFirst,data=train,family='binomial')
test$probabilities<-predict(fit,newdata=test,type='response')

test<-test[,c('X','probabilities')]
write.csv(test,'submission_all.csv',row.names=FALSE)

