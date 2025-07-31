# This function computes the ROC and AUROC for a given sample of events and forecasts.

# --------------------------------------
# Function
# --------------------------------------

roc.auroc <- function( actual, forecast, figure.roc=TRUE, print.results=TRUE ){

# The following computations are based on the assumption that actual is given in event format = 0, 1.
# If you analyze, for example, returns that assume realizations on the real line then recode the actual returns to 0, 1 format before calling this program.
# For example, define returns<=0 as event 0 and returns>0 as event 1. That is, event 1 is the event where returns are expected to be larger.

# --------------------------------------
# Define series to be analyzed
# --------------------------------------

# Define a dataframe that contains the actual values and the forecasts
data.both <- data.frame( actual, forecast )

# Order the dataframe in ascending order conditional on the forecasts (from small to large values)
data.both <- data.both[ order(forecast), ]

# Convert the columns of the dataframe to vectors (easier to use in computations below)
actual <- data.both$actual
forecast <- data.both$forecast

# Housekeeping
rm(data.both)

# --------------------------------------
# Loop over cutoff values to compute ROC
# --------------------------------------

# Define the range of the cutoff value
cutoff <- sort( forecast, decreasing=TRUE )

#  Add max(forecast)+1 to set the initial value for cutoff > max(forecast) / this forces the ROC to start at 0,0
cutoff <- c( (max(forecast)+1), cutoff )

# Objects that contain results for the sensitivity / specificity
Se <- matrix(0, nrow=length(cutoff), ncol=1)
Sp <- matrix(0, nrow=length(cutoff), ncol=1)

# Loop over cutoff values to compute ROC
for( jj in 1:length(cutoff) ){

	# Contingency table / 2 - by - 2
	correct.signals <- (actual==1) * (forecast>=cutoff[jj])
	incorrect.signals <- (actual==0) * (forecast>=cutoff[jj])
	correct.nonsignals <- (actual==0) * (forecast<cutoff[jj])
	incorrect.nonsignals <- (actual==1) * (forecast<cutoff[jj])
	
	# Computation of sensitivity  / proportion of correct signals  / jj + 1 to account for initial value for cutoff > max(forecast)
	Se[jj] <- sum(correct.signals) /( sum(correct.signals) + sum(incorrect.nonsignals) )

	# Computation of specificity / proportion of correct nonsignals  / jj + 1 to account for initial value for cutoff > max(forecast)
	Sp[jj] <- sum(correct.nonsignals) /( sum(incorrect.signals) + sum(correct.nonsignals) )

}

# Housekeeping
rm(jj)

# --------------------------------------
# Graph: ROC curve
# --------------------------------------

if(figure.roc==TRUE){

	# Select plot parameters
	quartz( height=5, width=8)
	par( mgp=c(3,1,0), mar=c(5,5,2,1)+0.1, mfrow=c(1,1) )
	
	# Plot ROC
	plot(1-Sp, Se, type="b", lwd=1.5,  cex=1.2, cex.axis=1.2, cex.lab=1.2, main="ROC curve",
		xlim=c(0,1), ylim=c(0,1), xaxs="i", yaxs="i", col="darkblue",
	    xlab="1-Specificity", ylab="Sensitivity")	    
	abline(a=0, b=1, lwd=3, col="darkgreen" )
	
# End if loop
}

# Housekeeping
# rm( Se, Sp )

# --------------------------------------
# Compute AUROC (area under the ROC curve)
# --------------------------------------

# Mann-Whitney rank sum test
w.test <- wilcox.test(forecast[actual==0], forecast[actual==1], paired=FALSE, exact=FALSE, mu=0)
w.test <- w.test[[1]][[1]]

# Area under the ROC curve 
nn.sum <- sum(actual==1)*sum(actual==0)
auroc <- (nn.sum - w.test) / nn.sum

# Standard error of area under the ROC curve 
q.1 <- auroc / (2-auroc)
q.2 <- 2*auroc^2 / (1+auroc)
var.auroc <- ( auroc*(1-auroc) + 
			  (length(forecast[actual==1])-1)*(q.1-auroc^2) + 
			  (length(forecast[actual==0])-1)*(q.2-auroc^2) ) / ( length(forecast[actual==0]) * length(forecast[actual==1]) )
se.auroc <- var.auroc^0.5

# Housekepping
rm( w.test, nn.sum, q.1, q.2, var.auroc)

# --------------------------------------
# Summarize the results in a table
# --------------------------------------

if(print.results==TRUE){

	# Define row names
	names.results <- c( "AUROC", "S.E. of AUROC", "- 1.96 Confidence Interval", "+ 1.96 Confidence Interval", "No. of nonevents", "No. of events", "Total" )
	
	# Summarize the results in a vector
	results <- rbind( auroc, se.auroc, auroc-1.96*se.auroc, auroc+1.96*se.auroc, length(actual[actual==0]), length(actual[actual==1]), length(actual[actual==0]) + length(actual[actual==1]) )
	
	# Assign row names
	row.names(results) <- names.results
	
	# Housekeeping
	rm(names.results)
	
	# Adjust format to present results in a more readable form
	results <- format(round(results,digits=5), justify="centre", width=10)
	
	# Convert to dataframe
	results <- as.data.frame(results)
	
	# Column name
	names(results) <- c("Result")
	
	# Print
	print(results)
	cat("\n")
	
	# Housekeeping
	rm(results)
	
	# End if loop
}

# --------------------------------------
# Hand over objects to the parent file
# --------------------------------------

return(list( auroc, se.auroc, Se, Sp, length(actual[actual==0]), length(actual[actual==1]), cutoff ) )

# --------------------------------------
# End Function
# --------------------------------------
}