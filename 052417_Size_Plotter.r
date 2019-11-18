setwd("C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/052317FirstDraft/Figure1")
color = c("green","red","blue")
strain = 0
pdf(file = "whi5_wt_bck2.pdf",width = 14, height = 14)
par(mar=c(5,5,2,5))

for(i in c(3,4741,29))
{
strain =strain+1
f=paste ("C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/052317FirstDraft/Figure1/012915/012915l/",i,"l.txt", sep = "", collapse = NULL)
S1<-read.table(f)
size=S1[1:(length(S1[,1])-2),1]
count=S1[1:(length(S1[,1])-2),2]
mean=sum(size*count)/sum(count)
x=log10(size/mean)
y=count/max(count)*100
par(new=t)
xmin=0
xmax=140
ymin=0
ymax=100
#plot(lowess(S1[1:(length(S1[,1])-2),1],y,f=0.03), xlim=c(xmin, xmax),ylim=c(ymin, ymax),col=i+25,pch=i%%25,cex=0,xlab="Cell Size",ylab="Proportion")
#lines(lowess(S1[1:(length(S1[,1])-2),1],y,f=0.03), xlim=c(xmin, xmax),ylim=c(ymin, ymax),col=i+25,pch=i%%25,lwd=10,cex=5,xlab="Cell Size",ylab="Proportion")
plot(S1[1:(length(S1[,1])-2),1],y, bty="n",
     xlim=c(xmin, xmax),ylim=c(ymin, ymax),
     yaxs = "i",xaxs = "i",
     col=i+25,pch=i%%25,cex=0,
     xlab="Cell Size",ylab="% of Max",
     cex.lab=2,
     xaxt="n",yaxt='n')
lines(S1[1:(length(S1[,1])-2),1],y,bty="n", 
      xlim=c(xmin, xmax),
      ylim=c(ymin, ymax),
      yaxs = "i",xaxs="i",
      col=color[strain],
      lwd=8,pch=i%%25,cex=5,
      xaxt="n",yaxt='n')

axis(1, lwd = 5,lwd.ticks=3,cex.axis = 2)
axis(2, lwd = 5,lwd.ticks=3,cex.axis = 2)
#legend('topright',legend=c("wt"),lwd=c(2.5,2.5),col=c(i+25))
}

dev.off()
