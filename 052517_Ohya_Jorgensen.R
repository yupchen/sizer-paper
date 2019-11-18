setwd("C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/052317FirstDraft/Figure4")
library(lattice)
plotlowess = function(x,y)
{seq = 0.1#3^((1:10)-5)
for(f in seq)
{
  lines(lowess(x,y,f = f,iter=100 ), col = f*100)
}

legend(65, 0.7, c(paste("LOWESS, f = ", c(seq))), lty = 1, col = f*100,bty = "n")
}

scatterhistlowess = function(x, y, xlab="", ylab=""){
  zones=matrix(c(2,0,1,3), ncol=2, byrow=TRUE)
  layout(zones, widths=c(4/5,1/5), heights=c(1/5,4/5))
  xhist = hist(x, breaks=100, plot=FALSE)
  yhist = hist(y, breaks=100, plot=FALSE)
  top = max(c(xhist$counts, yhist$counts))
  par(mar=c(3,3,1,1))
  plot(x,y,col = rgb(0,0,0,0.3))
  ##lowess
  plotlowess(x,y)
  ####
  par(mar=c(0,3,1,1))
  barplot(xhist$counts, axes=FALSE, ylim=c(0, top), space=0)
  par(mar=c(3,0,1,1))
  barplot(yhist$counts, axes=FALSE, xlim=c(0, top), space=0, horiz=TRUE)
  par(oma=c(3,3,0,0))
  mtext(xlab, side=1, line=0.01, outer=TRUE, adj=0, 
        at=0.4)#(mean(x) - min(x))/(max(x)-min(x)))
  mtext(ylab, side=2, line=0.01, outer=TRUE, adj=0, 
        at=0.4)#((mean(y) - min(y))/(max(y) - min(y))))
}


##load file
f=c("haploid_size_coulter_counter.txt")
Size_matrix<-read.table(f)
## Extract numbers, strains in rows
Snum=as.matrix(Size_matrix[,1:(dim(Size_matrix)[2]-2)])

## Define sizes, column vector
size=Snum[1,]
CV=numeric()
mean=numeric()
for(row in c(2:nrow(Size_matrix)))
{
  ## Mark name. Calculate mean for each strain i
  
  count=Snum[row,]
  totalcount=sum(Snum[row,])
  meanvalue = size%*%count/totalcount
  ## Calculate standard deviation
  sqdifference=numeric(1)
  for (bin in c(1:length(size)))
  {
    sqdifference=sqdifference + count[bin]*((size[bin]-meanvalue)^2)
  }
  standarddev=sqrt(sqdifference/totalcount)
  ## Calculate CV
  CV=rbind(CV,standarddev/meanvalue)
  mean = rbind(mean,meanvalue)
}
name = as.character(Size_matrix[2:nrow(Size_matrix),ncol(Size_matrix)])
orf = as.character(Size_matrix[2:nrow(Size_matrix),(ncol(Size_matrix)-1)])
report= cbind(orf,name,CV,mean)
colnames(report) = c("orf","name","CV","mean")

# measure residuals to the lowess line
####depending on the final f value, the following code needs to be refined
# create a functional version of the lowess fit
f=0.1
lowessline = approxfun(lowess(mean,CV,f = f,iter=100 ))
fitted <- lowessline(mean)
lowessresidue = CV - fitted


#####load in Ohya data
# load file
Ohya=c("Ohya_mean_CV_mother_with_s_m_bud.txt")
Ohyadata<-read.table(Ohya,header = T)

## Append numbers to report
OhyaCV=vector(,dim(report)[1])
Ohyamean=vector(,dim(report)[1])
reportJandO = cbind(report,OhyaCV)
reportJandO = cbind(reportJandO,Ohyamean)
row.names(reportJandO)=reportJandO[,"orf"]
reportJandO = cbind(reportJandO,1:dim(reportJandO)[1])
colnames(reportJandO) [7] = "id"

reportJandO[,"OhyaCV"] = Ohyadata[match(reportJandO[,"orf"],Ohyadata[,"name"]),"CV"]
reportJandO[,"Ohyamean"] = Ohyadata[match(reportJandO[,"orf"],Ohyadata[,"name"]),"mean"]
#extract CV and mean
OhyaCV = as.numeric(reportJandO[,"OhyaCV"])
Ohyamean = as.numeric(reportJandO[,"Ohyamean"])
is.na(OhyaCV) == is.na(Ohyamean)
OhyaCVnarm = OhyaCV[!is.na(OhyaCV)]
Ohyameannarm = Ohyamean[!is.na(Ohyamean)]


# measure residuals to the lowess line
####depending on the final f value, the following code needs to be refined
# create a functional version of the lowess fit
f=0.1
Ohyalowessline = approxfun(lowess(Ohyameannarm,OhyaCVnarm,f = f,iter=100 ))
Ohyafitted <- Ohyalowessline(Ohyameannarm)
Ohyalowessresidue = OhyaCVnarm - Ohyafitted

# reserve na to match position
Ohyafitted <- Ohyalowessline(Ohyamean)
Ohyalowessresidue = OhyaCV - Ohyafitted


# plot Ohya residue against Jorgensen residue
pdf(file = "Figure4.pdf",width = 14, height = 14)
plot(Ohyalowessresidue,lowessresidue, col = rgb(0,0,0,0.01),xlab = "Ohya LOWESS Residue", ylab = "Jorgensen LOWESS Residue")
for(gene in which(!is.na(OhyaCV)))
{
  #text(Ohyalowessresidue[gene],lowessresidue[gene],reportJandO[gene,"orf"],cex = 0.5)
  points(Ohyalowessresidue[gene],lowessresidue[gene],col = rgb(0,0,0,0.3))
}
# top 10 percent line
abline(v =Ohyalowessresidue[order(Ohyalowessresidue,decreasing = TRUE)][(floor(length(which(!is.na(OhyaCV))))/10)], lty = 2)
abline(h =lowessresidue[order(lowessresidue,decreasing = TRUE)][(floor(length(which(!is.na(OhyaCV))))/10)],lty=2)

dev.off()