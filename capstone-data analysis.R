library(ggplot2) 
library(heatmaply)
library(usdm)
setwd("C:/Users/shhwa/DS 340H")

bluebike_weekly <- read.csv("bluebike_weekly.csv")
bluebike_weekly <- bluebike_weekly[,-c(1)]

## EXPLORATION------------------

#seeing distribution 
hist(bluebike_weekly$count_per_week) #not logging 

bw <- bluebike_weekly[, -c(7,8)]  # Removing week col
bw <- as.data.frame(lapply(bw, as.numeric))

#correlation heatmap
cor_matrix <- cor(bw)
heatmaply(cor_matrix,
          main = "Correlation Heatmap Of Weekly Bluebike Trips", 
          scale = "none",  # No scaling since this is correlation matrix
          colors = colorRampPalette(c("blue", "white", "red"))(100), 
          dendrogram = "both",  
          xlab = "Features",  
          ylab = "Features")

#

#multicollinearity 
vifstep(bw[,-1], th=10) #no eliminations 

## CV setup-----------------------
n <- dim(bluebike_weekly)[1]
K <- 10 #-fold CV
n.fold <- ceiling(n/K) #size of each fold, rounded down to the nearest integer
set.seed(1)
n.shuffle <- sample(1:n, n, replace=FALSE) #shuffle the n indexes
index.fold <- list()
for(i in 1:K)
{
  if(i<K)
  {
    index.fold[[i]] <- n.shuffle[((i-1)*n.fold+1):(i*n.fold)]
  }else
  {
    index.fold[[i]] <- n.shuffle[((K-1)*n.fold+1):n]
  }
}

## MODELING---------------------

## LINEAR REGRESSION

#aic
lm.obj <- lm(count_per_week~., data=bluebike_weekly)
aic <- step(lm.obj, k=2, direction="both", trace=FALSE)
#count_per_week ~ gas_price + new_covid_cases + tavg + prcp + season
summary(aic)

#bic
n <- dim(bluebike_weekly)[1]
bic <- step(lm.obj, k=log(n), direction="both", trace=FALSE)
#count_per_week ~ gas_price + new_covid_cases + tavg + prcp + season
summary(bic)

#yields the same first-order model 
CV.score.fo <- 0
for(i in 1:K)
{
  #fit the full model based on the data excluding the ith fold
  fit <- lm(count_per_week ~ gas_price + new_covid_cases + tavg + prcp + season, 
            data=bluebike_weekly[-index.fold[[i]],])
  #make prediction on each observation in the ith fold
  pred <- predict(fit,bluebike_weekly[index.fold[[i]],])
  #compute average squared error for the ith fold
  CV.score.fo <- CV.score.fo+(1/n)*sum((bluebike_weekly$count_per_week[index.fold[[i]]]-pred)^2)
}
sqrt(CV.score.fo)
AIC(bic)
BIC(bic)

#higher order aic
aic.2 <- step(lm.obj, .~.^2, direction="both", k=2)
#count_per_week ~ gas_price + new_covid_cases + tavg + prcp + 
# month + season + month:season + new_covid_cases:season + 
# tavg:season + gas_price:season + tavg:month + gas_price:new_covid_cases
summary(aic.2)

CV.score.ho <- 0
for(i in 1:K)
{
  #fit the full model based on the data excluding the ith fold
  fit <- lm(count_per_week ~ gas_price + new_covid_cases + tavg + prcp + 
            month + season + month:season + new_covid_cases:season + 
            tavg:season + gas_price:season + tavg:month + gas_price:new_covid_cases, 
            data=bluebike_weekly[-index.fold[[i]],])
  #make prediction on each observation in the ith fold
  pred <- predict(fit,bluebike_weekly[index.fold[[i]],])
  #compute average squared error for the ith fold
  CV.score.ho <- CV.score.ho+(1/n)*sum((bluebike_weekly$count_per_week[index.fold[[i]]]-pred)^2)
}
sqrt(CV.score.ho)
AIC(aic.2)
BIC(aic.2)

#higher order bic
bic.2 <- step(lm.obj, .~.^2, direction="both", k=log(n))
#count_per_week ~ gas_price + new_covid_cases + tavg + 
# prcp + month + season + month:season + new_covid_cases:season + 
# tavg:season + gas_price:tavg
summary(bic.2)

CV.score.ho2 <- 0
for(i in 1:K)
{
  #fit the full model based on the data excluding the ith fold
  fit <- lm(count_per_week ~ gas_price + new_covid_cases + tavg + 
            prcp + month + season + month:season + new_covid_cases:season + 
            tavg:season + gas_price:tavg, 
            data=bluebike_weekly[-index.fold[[i]],])
  #make prediction on each observation in the ith fold
  pred <- predict(fit,bluebike_weekly[index.fold[[i]],])
  #compute average squared error for the ith fold
  CV.score.ho2 <- CV.score.ho2+(1/n)*sum((bluebike_weekly$count_per_week[index.fold[[i]]]-pred)^2)
}
sqrt(CV.score.ho2)
AIC(bic.2)
BIC(bic.2)

anova(aic, aic.2)
anova(aic, bic.2)

## SUPPORT VECTOR REGRESSION

library(e1071)
bw$count_per_week <- as.numeric(bw$count_per_week)

svm.fit <- svm(formula=count_per_week~., data=bw, type="eps-regression", 
               kernel="linear", cost=1)
summary(svm.fit)

CV.score.svm <- 0
for(i in 1:K)
{
  #fit the full model based on the data excluding the ith fold
  svm_train <- bw[-index.fold[[i]], ]
  svm_test <- bw[index.fold[[i]], ]
  svm.fit <- svm(formula=count_per_week~., data=svm_train,
                 type="eps-regression", kernel="linear", cost=1)
  #make prediction on each observation in the ith fold
  pred <- predict(svm.fit,newdata=svm_test)
  #compute average squared error for the ith fold
  CV.score.svm <- CV.score.svm+(1/n)*sum((svm_test$count_per_week-pred)^2)
}
sqrt(CV.score.svm)


## CONCLUSION-----------

aic2.fit <- lm(count_per_week ~ gas_price + new_covid_cases + tavg + 
                 prcp + month + season + month:season + new_covid_cases:season + 
                 tavg:season + gas_price:season + tavg:month + gas_price:new_covid_cases, 
               data=bluebike_weekly)
par(mfrow=c(2,2))
plot(aic2.fit)

#eliminating repeating outliers
bluebike_weekly <- bluebike_weekly[-c(140,142,195),]
fit.final <- lm(count_per_week ~ gas_price + new_covid_cases + tavg + 
                 prcp + month + season + month:season + new_covid_cases:season +
                 tavg:season + gas_price:tavg, data=bluebike_weekly)
par(mfrow=c(2,2))
plot(fit.final)

summary(fit.final)

