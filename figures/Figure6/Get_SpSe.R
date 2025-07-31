
rm(list=ls())
# set folder Figure6 as working directory
setwd()

# --------------------------------------
# Functions
# --------------------------------------
source("svroc.R")
source("rolling.R")

# --------------------------------------
# Load data
# --------------------------------------
rolling.length <- 48
axis.time <- seq(as.Date("2001/1/1"), as.Date("2021/6/1"), by="1 months")

# Forecast with SVBVAR model using Baumeister and Hamilton (2019)'s World Industrial Production (WIP) index 
BKL.data <- read.table("/Users/luigigifuni/Desktop/Chapter 2 PhD Glasgow/Codes/Figures/Figure7/data/BKL.txt",sep=",",header=TRUE,na.strings="--")

# Forecast with SVBVAR model using Baumeister and Hamilton (2019)'s World Industrial Production (WIP) index plus TOSI 
GvsBKL.data <- read.table("/Users/luigigifuni/Desktop/Chapter 2 PhD Glasgow/Codes/Figures/Figure7/data/GvsBKL.txt",sep=",",header=TRUE,na.strings="--")

# Forecast with SVBVAR model using Kilian (2009)'s index (REA)
K.data <- read.table("/Users/luigigifuni/Desktop/Chapter 2 PhD Glasgow/Codes/Figures/Figure7/data/K.txt",sep=",",header=TRUE,na.strings="--")

# Forecast with SVBVAR model using Kilian (2009)'s index (REA) plus TOSI
GvsK.data <- read.table("/Users/luigigifuni/Desktop/Chapter 2 PhD Glasgow/Codes/Figures/Figure7/data/GvsK.txt",sep=",",header=TRUE,na.strings="--")

BKL <- svroc(BKL.data)
GvsBKL <- svroc(GvsBKL.data)
K <- svroc(K.data)
GvsK <- svroc(GvsK.data)

BKLauroc <- rolling(BKL.data,rolling.length)
GvsBKLauroc <- rolling(GvsBKL.data,rolling.length)
Kauroc <- rolling(K.data,rolling.length)
GvsKauroc <- rolling(GvsK.data,rolling.length)

# Define current and forecast values
Sp <- unlist(BKL[1], use.names=FALSE)
Se <- unlist(BKL[2], use.names=FALSE)
SpT <- unlist(GvsBKL[1], use.names=FALSE)
SeT <- unlist(GvsBKL[2], use.names=FALSE)
SpK <- unlist(K[1], use.names=FALSE)
SeK <- unlist(K[2], use.names=FALSE)
SpKT <- unlist(GvsK[1], use.names=FALSE)
SeKT <- unlist(GvsK[2], use.names=FALSE)

# --------------------------------------
# Graph: ROC curve
# --------------------------------------

#pdf(file = "plot1.pdf", width = 16, height = 8)
#par( mgp=c(3,1,0), mar=c(5,5,2,5)+0.1, mfrow=c(1,2) )
# Plot ROC SVBVAR with WIP
plot(1-SpT, SeT, type="l", lwd=3, main="ROC curves", xlim=c(0,1), ylim=c(0,1), 
     xaxs="i", yaxs="i", col="#1E3D59", lty = 1, xlab="FP", ylab="TR")
lines(1-Sp, Se, type="l",lwd=3, xlim=c(0,1), ylim=c(0,1), xaxs="i", yaxs="i", col="#A38C9C", lty = 1)
abline(a=0, b=1, lwd=3, lty=2, col="red" )
legend(0.5,0.5, c("SVBVAR with WIP & TOSI","SVBVAR with WIP", "45° benchmark line"), lty=c(1,1,2), 
       bty="n", col=c("#1E3D59","#A38C9C","red"), lwd=3,cex = 0.5)
#dev.off()
#dev.list()
#par(new=TRUE)

#pdf(file = "plot2.pdf", width = 16, height = 8)
#par( mgp=c(3,1,0), mar=c(5,5,2,1)+0.1, mfrow=c(2,2) )
# Plot ROC SVBVAR with WIP
plot(1-SpKT, SeKT, type="l", lwd=3, main="ROC curves", xlim=c(0,1), ylim=c(0,1), 
     xaxs="i", yaxs="i", col="#1E3D59", lty = 1, xlab="FP", ylab="TR")
lines(1-SpK, SeK, type="l",lwd=3, xlim=c(0,1), ylim=c(0,1), xaxs="i", yaxs="i", col="#A38C9C", lty = 1)
abline(a=0, b=1, lwd=3, lty=2, col="red" )
legend("bottomright", c("SVBVAR with REA & TOSI","SVBVAR with REA", "45° benchmark line"), lty=c(1,1,2), 
       bty="n", col=c("#1E3D59","#A38C9C","red"), lwd=3)
#dev.off()
#dev.list()
#par(new=TRUE)

# --------------------------------------
# Graph: AUROC curve WIP
# --------------------------------------

# Select plot parameters
col.list <- c("#1E3D59","#A38C9C")

#pdf(file = "plot3.pdf", width = 16, height = 8)
#par( mgp=c(3,1,0), mar=c(5,5,2,5)+0.1, mfrow=c(1,1) )

# Plot AUROC
plot(axis.time[-1:-rolling.length], GvsBKLauroc, type="l", lwd=3,  cex=1.7, cex.axis=1.7, 
     cex.lab=1.7, main="Brent 1-month ahead forecasts", xaxs="i", yaxs="i", col=col.list[1], 
     ylab="AUROC", ylim=c(0.35,0.9), lty = 2, xlab="")
points(axis.time[-1:-rolling.length], GvsBKLauroc, pch=4, lwd=2, col=col.list[1])
lines(axis.time[-1:-rolling.length], BKLauroc, type="l", lwd=3,  cex=1.7, cex.axis=1.7, 
     cex.lab=1.7, xaxs="i", yaxs="i", col=col.list[2], lty = 2)
points(axis.time[-1:-rolling.length], BKLauroc, pch=4, lwd=2, col=col.list[2])
grid(NA, 40, lwd = 2) # grid only in y-direction
legend("bottomright", c("SVBVAR with WIP & TOSI","SVBVAR with WIP"), lty=c(1,1), 
       bty="n", col=col.list, lwd=3,  cex=1.7, pch=c(4,4))
#dev.off()
#par(new=TRUE)

# --------------------------------------
# Graph: AUROC curve REA
# --------------------------------------

# Select plot parameters
col.list <- c("#1E3D59","#A38C9C")

#pdf(file = "plot4.pdf", width = 16, height = 8)
par( mgp=c(3,1,0), mar=c(5,5,2,5)+0.1, mfrow=c(1,1) )

# Plot AUROC
plot(axis.time[-1:-rolling.length], GvsKauroc, type="l", lwd=3,  cex=1.7, cex.axis=1.7, 
     cex.lab=1.7, main="Brent 1-month ahead forecasts", xaxs="i", yaxs="i", col=col.list[1], 
     ylab="AUROC", ylim=c(0.25,0.8), lty = 2, xlab="")
points(axis.time[-1:-rolling.length], GvsKauroc, pch=4, lwd=2, col=col.list[1])
lines(axis.time[-1:-rolling.length], Kauroc, type="l", lwd=3,  cex=1.7, cex.axis=1.7, 
      cex.lab=1.7, xaxs="i", yaxs="i", col=col.list[2], lty = 2)	
points(axis.time[-1:-rolling.length], Kauroc, pch=4, lwd=2, col=col.list[2])
grid(NA, 40, lwd = 2) # grid only in y-direction
legend("bottomright", c("SVBVAR with REA & TOSI","SVBVAR with REA"), lty=c(1,1), 
       bty="n", col=col.list, lwd=3,  cex=1.7, pch=c(4,4))
dev.off()
#par(new=TRUE)
