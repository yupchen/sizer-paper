setwd("C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/052317FirstDraft/Figure3")
color = rainbow(32)#c("green","red","blue","pink")

#pdf(file = "111719_Coudreuse_Nurse_method.pdf",width = 14, height = 14)
#par(mar=c(5,5,2,5))

strain = 0
plot.new()
for(i in c(18))#c(1:30,4741,4742))
  {
  par(new=T)
  strain =strain+1
  f=paste ("C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/052317FirstDraft/Figure3/012915/012915l/",i,"l.txt", sep = "", collapse = NULL)
  S1<-read.table(f)
  size=S1[1:(length(S1[,1])-2),1]
  count=S1[1:(length(S1[,1])-2),2]
  all_cells = NULL
  for (i in 1:length(size)){
    
    all_cells = append(all_cells,rep(size[i],count[i]))
  }
  
  median = median(all_cells)
  hist = hist(all_cells/median,breaks = c(seq(0,2,0.2),5),plot=FALSE) 
  x = hist$mids[1:10]
  y = hist$density[1:10]/sum(hist$density[1:10])
  plot(x,y, bty="n",
       xlim=c(0, 2),ylim=c(0, 0.25),
       yaxs = "i",xaxs = "i",
       col=i+25,pch=i%%25,cex=0,
       cex.lab=2,
       xaxt="n",yaxt='n')
  lines(x,y,bty="n", 
        xlim=c(0, 2),
        ylim=c(0, 1),
        yaxs = "i",xaxs="i",
        col=color[strain],
        lwd=1,pch=i%%25,cex=5,
        xaxt="n",yaxt='n')
  

  #legend('topright',legend=c("wt"),lwd=c(2.5,2.5),col=c(i+25))
}
par(new=T)
plot(x,y, bty="n",
     xlim=c(0, 2),ylim=c(0, 0.25),
     yaxs = "i",xaxs = "i",
     col=i+25,pch=i%%25,cex=0,
     xlab="Fraction of median",ylab="Fraction of cells",
     cex.lab=2,
     xaxt="n",yaxt='n')
axis(1, lwd = 5,lwd.ticks=3,cex.axis = 2,at = c(0, seq(from = 0, to = 2, by = 0.2),1))
axis(2, lwd = 5,lwd.ticks=3,cex.axis = 2)

#dev.off()

