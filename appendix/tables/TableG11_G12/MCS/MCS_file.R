rm(list = ls())
 
require(R.matlab)
require(MCS)
require(xtable)
 
 
# change directory
setwd("C:/Users/pfb22164/OneDrive - University of Strathclyde/Documents/Projects/JMP/Codes/Tables/Table6/MCS/Results")

# load results
# load("MCS_results.RData")
 
# load files
mspe1 <- readMat('mspe1.mat')
mspe3 <- readMat('mspe3.mat')
mspe6 <- readMat('mspe6.mat')
mspe12 <- readMat('mspe12.mat')
mspe24 <- readMat('mspe24.mat')
 
for(jj in 1:3){
  MSPE1 <- cbind(mspe1$mspe1[,1,jj],mspe1$mspe1[,2,jj],mspe1$mspe1[,3,jj],mspe1$mspe1[,4,jj],
                       mspe1$mspe1[,5,jj],mspe1$mspe1[,6,jj],mspe1$mspe1[,7,jj],mspe1$mspe1[,8,jj])
  MCS1 <- MCSprocedure(Loss = MSPE1, alpha = 0.01, B = 5000, statistic = 'Tmax')
 
  if (jj == 1) {
    assign("MCS1_WTI", MCS1)
  } else if (jj == 2) {
    assign("MCS1_RAC", MCS1)
  } else if (jj == 3) {
    assign("MCS1_BRENT", MCS1)
  }
}
 
for(jj in 1:3){
  MSPE3 <- cbind(mspe3$mspe3[,1,jj],mspe3$mspe3[,2,jj],mspe3$mspe3[,3,jj],mspe3$mspe3[,4,jj],
                 mspe3$mspe3[,5,jj],mspe3$mspe3[,6,jj],mspe3$mspe3[,7,jj],mspe3$mspe3[,8,jj])
 
  MCS3 <- MCSprocedure(Loss = MSPE3, alpha = 0.01, B = 5000, statistic = 'Tmax')
 
  if (jj == 1) {
    assign("MCS3_WTI", MCS3)
  } else if (jj == 2) {
    assign("MCS3_RAC", MCS3)
  } else if (jj == 3) {
    assign("MCS3_BRENT", MCS3)
  }
}
 
for(jj in 1:3){
  MSPE6 <- cbind(mspe6$mspe6[,1,jj],mspe6$mspe6[,2,jj],mspe6$mspe6[,3,jj],mspe6$mspe6[,4,jj],
                 mspe6$mspe6[,5,jj],mspe6$mspe6[,6,jj],mspe6$mspe6[,7,jj],mspe6$mspe6[,8,jj])
 
  MCS6 <- MCSprocedure(Loss = MSPE6, alpha = 0.01, B = 5000, statistic = 'Tmax')
 
  if (jj == 1) {
    assign("MCS6_WTI", MCS6)
  } else if (jj == 2) {
    assign("MCS6_RAC", MCS6)
  } else if (jj == 3) {
    assign("MCS6_BRENT", MCS6)
  }
}
 
for(jj in 1:3){
  MSPE12 <- cbind(mspe12$mspe12[,1,jj],mspe12$mspe12[,2,jj],mspe12$mspe12[,3,jj],mspe12$mspe12[,4,jj],
                  mspe12$mspe12[,5,jj],mspe12$mspe12[,6,jj],mspe12$mspe12[,7,jj],mspe12$mspe12[,8,jj])
 
  MCS12 <- MCSprocedure(Loss = MSPE12, alpha = 0.01, B = 5000, statistic = 'Tmax')
 
  if (jj == 1) {
    assign("MCS12_WTI", MCS12)
  } else if (jj == 2) {
    assign("MCS12_RAC", MCS12)
  } else if (jj == 3) {
    assign("MCS12_BRENT", MCS12)
  }
}
 
for(jj in 1:3){
  MSPE24 <- cbind(mspe24$mspe24[,1,jj],mspe24$mspe24[,2,jj],mspe24$mspe24[,3,jj],mspe24$mspe24[,4,jj],
                  mspe24$mspe24[,5,jj],mspe24$mspe24[,6,jj],mspe24$mspe24[,7,jj],mspe24$mspe24[,8,jj])
 
  MCS24 <- MCSprocedure(Loss = MSPE24, alpha = 0.01, B = 5000, statistic = 'Tmax')
 
  if (jj == 1) {
    assign("MCS24_WTI", MCS24)
  } else if (jj == 2) {
    assign("MCS24_RAC", MCS24)
  } else if (jj == 3) {
    assign("MCS24_BRENT", MCS24)
  }
}
 
# Save results
save(MCS1_WTI, MCS1_RAC, MCS1_BRENT,
     MCS3_WTI, MCS3_RAC, MCS3_BRENT,
     MCS6_WTI, MCS6_RAC, MCS6_BRENT,
     MCS12_WTI, MCS12_RAC, MCS12_BRENT,
     MCS24_WTI, MCS24_RAC, MCS24_BRENT,
     file = "MCS_results.RData")
 
# Assuming you have already loaded the required libraries and data
 
# Function to extract MCS_R from a given MCS object and model index
extract_MCS_R <- function(MCS_obj, model_index) {
  # Extract MCS_R for the given model index from the 'show' slot
  MCS_R_value <- slot(MCS_obj, "show")[model_index, "MCS_R"]
  return(MCS_R_value)
}
 
# Create an empty list to store the results
model_names <- c("model_1", "model_2", "model_3", "model_4", "model_5", "model_6", "model_7", "model_8")
 
# Prepare the results in a matrix for each model (8 rows, 12 columns)
results_matrix <- matrix(ncol = 12, nrow = 8)
 
# Loop through each model and extract MCS_R for all MCS objects
for (i in 1:8) {
  # Fill in each column for the current model (i)
  results_matrix[i, 1] <- extract_MCS_R(MCS1_WTI, i)
  results_matrix[i, 2] <- extract_MCS_R(MCS1_BRENT, i)
  results_matrix[i, 3] <- extract_MCS_R(MCS3_WTI, i)
  results_matrix[i, 4] <- extract_MCS_R(MCS3_BRENT, i)
  results_matrix[i, 5] <- extract_MCS_R(MCS6_WTI, i)
  results_matrix[i, 6] <- extract_MCS_R(MCS6_BRENT, i)
  results_matrix[i, 7] <- extract_MCS_R(MCS12_WTI, i)
  results_matrix[i, 8] <- extract_MCS_R(MCS12_BRENT, i)
  results_matrix[i, 9] <- extract_MCS_R(MCS24_WTI, i)
  results_matrix[i, 10] <- extract_MCS_R(MCS24_BRENT, i)
}
 
# Convert the matrix to a data frame with the appropriate column names
results_df <- data.frame(
  Model = model_names,
  MCS1_WTI = results_matrix[, 1],
  MCS1_BRENT = results_matrix[, 2],
  MCS3_WTI = results_matrix[, 3],
  MCS3_BRENT = results_matrix[, 4],
  MCS6_WTI = results_matrix[, 5],
  MCS6_BRENT = results_matrix[, 6],
  MCS12_WTI = results_matrix[, 7],
  MCS12_BRENT = results_matrix[, 8],
  MCS24_WTI = results_matrix[, 9],
  MCS24_BRENT = results_matrix[, 10]
)
 
# Use xtable to create the LaTeX table
latex_table <- xtable(results_df, digits = c(0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3), caption = "MCS Results for Different Models")
 
# Print the LaTeX table
print(latex_table, type = "latex", caption.placement = "top")