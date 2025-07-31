
auroc.sub <- function(data){
  
  # Rename data to make sure that loaded (subsample) data are unchanged
  forecast <- data
  
  # Select variables (actual(t), forecast(t) )
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
  # Function
  # --------------------------------------
  
  
  roc.auroc.results <- roc.auroc( actual=actual, forecast=forecast, figure.roc=FALSE, print.results=FALSE )
  
  auroc <- roc.auroc.results[[1]][[1]]
  se.auroc <- roc.auroc.results[[2]][[1]]
  Se <- roc.auroc.results[[3]]
  Sp <- roc.auroc.results[[4]]
  actual.0 <- roc.auroc.results[[5]][[1]]
  actual.1 <- roc.auroc.results[[6]][[1]]
  cutoff <- roc.auroc.results[[7]]
  
  # --------------------------------------
  # Results
  # --------------------------------------
  
  # Object that contains the results
  results <- matrix( 0,nrow=1,ncol=11 )
  
  # Summarize the results in a vector
  results <- c( auroc, se.auroc, 2*(1-pnorm( abs( (auroc-0.5)/se.auroc) ) ),
                actual.0, actual.1, actual.0 + actual.1 )
  
  # --------------------------------------
  # Polish table for presentation
  # --------------------------------------
  
  # Adjust format to present results in a more readable form
  results <- format( round( results,digits=4 ), justify="centre", width=10 )
  
  # Convert to dataframe
  results <- as.data.frame( results )
  
  # Define row names
  row.names(results) <- c( "AUROC", "S.E. of AUROC",
                           "p value",
                           "No. of nonevents", "No. of events", "Total" )
  
  return( results )
}