
svroc <- function(data){
    
# --------------------------------------
# ROC curves in Figure 7
# --------------------------------------

# Rename data
foreBKL <- data

# Select variables (actual(t), forecast(t) )
for( jj in 2:( dim(foreBKL)[2]-1 ) ){ # 2: Actual in column 1, -3: No obs, Mean, Mean lag
	xx <- cbind(foreBKL$Actual,foreBKL[,jj])
	
	# Add lagged inflation rate
	xx <- as.matrix(xx)
	xx <- embed(xx, dimension=2)
	xx <- xx[,1:3] # c("actual","forecast","actual_lag")	

	# Stack data
	if( jj==2 ) yy <- xx
	if( jj>2 ) yy <- rbind(yy,xx)
}

# --------------------------------------
# Collect variables, delete NA rows
# --------------------------------------

all <- data.frame( yy )
names(all) <- c("actual","forecast","actual_lag")
all <- na.omit(all)

cat("----","\n")
cat("No of forecasts:",dim(all)[1],"\n")
cat("----","\n")

# Remove intermediate results
rm( xx, yy )

# --------------------------------------
# Define change
# --------------------------------------

forecaster <- all

forecaster$outcome <- as.numeric( as.vector( forecaster$actual ) ) - as.numeric( as.vector( forecaster$actual_lag ) )
forecaster$test <- as.numeric( as.vector( forecaster$forecast ) ) - as.numeric( as.vector( forecaster$actual_lag ) ) 

# Remove intermediate results
rm( all )

# --------------------------------------
# Define the actual values and the forecasts
# --------------------------------------

actual <- (forecaster$outcome>0)*1
forecast <- forecaster$test

# --------------------------------------
# Function
# --------------------------------------

source("roc.auroc.r")
roc.auroc.results <- roc.auroc( actual=actual, forecast=forecast, figure.roc=FALSE, print.results=FALSE )

auroc <- roc.auroc.results[[1]][[1]]
se.auroc <- roc.auroc.results[[2]][[1]]
Se <- roc.auroc.results[[3]]
Sp <- roc.auroc.results[[4]]
actual.0 <- roc.auroc.results[[5]][[1]]
actual.1 <- roc.auroc.results[[6]][[1]]
cutoff <- roc.auroc.results[[7]]

rm( roc.auroc.results )

# Object that contains the results
results <- matrix( 0,nrow=1,ncol=11 )

# Summarize the results in a vector
results <- c( auroc, se.auroc, 2*(1-pnorm( abs( (auroc-0.5)/se.auroc) ) ),
				   actual.0, actual.1, actual.0 + actual.1 )

rm( auroc, se.auroc, actual.0, actual.1 )

return(list(Sp=Sp,Se=Se))
}