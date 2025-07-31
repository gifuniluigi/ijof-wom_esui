rolling <- function(data,rolling.length){
  
# --------------------------------------
# rolling AUROC curves in Figure 7
# --------------------------------------

axis.time <- seq(as.Date("2001/1/1"), as.Date("2021/6/1"), by="1 months")

# Rename data
forecast <- data

# Select variables (actual(t), forecast(t), mean lag(t)  )
for( jj in 2:( dim(forecast)[2]-1 ) ){ # 2: Actual in column 1, -3: No obs, Mean, Mean lag
	xx <- cbind(forecast$Actual,forecast[,jj])
	
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
# Loop over time, rolling window
# --------------------------------------

result <- matrix(0, nrow=(length(axis.time)-rolling.length), ncol=2)

for(jj.time in 1:( dim(data)[1]-rolling.length) ){

	# --------------------------------------
	# Function
	# --------------------------------------

	actual.input <- actual[jj.time:(jj.time + rolling.length - 1)]
	forecast.input <- forecast[jj.time:(jj.time + rolling.length - 1)]
	
	source("roc.auroc.r")
	roc.auroc.results <- roc.auroc( actual= actual.input, forecast= forecast.input, figure.roc=FALSE, print.results=FALSE )
	
	auroc <- roc.auroc.results[[1]][[1]]
	se.auroc <- roc.auroc.results[[2]][[1]]
	

	# --------------------------------------
	# Results
	# --------------------------------------
	
	# Summarize the results in a vector
	result[jj.time,] <- c( auroc, se.auroc )

	# Remove intermediate results
	rm( roc.auroc.results, auroc, se.auroc, actual.input, forecast.input )

# --------------------------------------
# End loop
# --------------------------------------

}

# --------------------------------------
# Results
# --------------------------------------

rolling.auroc <- result[,1]
rolling.auroc.se <- result[,2]

# Remove intermediate results
rm(result, actual, forecast)

# --------------------------------------
# Definition of inflation volatility
# --------------------------------------

oilprice.rolling <- NA
for(jj in 1:( dim(data)[1]-rolling.length) ) oilprice.rolling[jj] <- var( data$Actual[jj:(jj + rolling.length - 1)], na.rm=TRUE )^0.5



return(rolling.auroc=rolling.auroc)
}