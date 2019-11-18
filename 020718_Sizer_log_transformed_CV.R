folder = "C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/Sizer/090419coulter_data"
CV=NULL
logCV=NULL
names=NULL
for(i in list.files(folder,pattern = "*.txt"))#c(1,29,4741))
{
  f=paste (folder,i,sep = "/", collapse = NULL)
  S1<-read.table(f)
  size=S1[15:(length(S1[,1])-2),1]
  count=S1[15:(length(S1[,1])-2),2]
  #mean=sum(size*count)/sum(count)
  # calculate median
    count_temp=0
    for(j in 1:length(count))
      {median_ceiling=size[j]
       if(count_temp<sum(count)/2){count_temp=count_temp+count[j]}
       else break
      }
  #x=log10(size/mean)
  x=size
  logx=log10(size)
  y=count
  dots = NULL
  logdots = NULL
  for(k in 1:length(y)){
    dots = append(dots,rep.int(x[k], y[k]))
    logdots = append(logdots,rep.int(logx[k], y[k]))
  }
  #result = shapiro.test(sample(dots,50))
  CV=append(CV,sd(dots)/mean(dots))
  logCV = append(logCV,sd(logdots)/mean(logdots))
  names=append(names,i)
  
}
results = cbind(names,CV,logCV)
txt.label = rep(c("GZ240","GZ241","BY4741","BY4742","A11","A12","A13","A14","bck2","whi5"), each=8)
results = cbind(txt.label,results)
slice = results[c(1:32,65:80),]
num.label = rep(1:6,each = 8)
slice = cbind(num.label,slice)

##############
ymin = 0
ymax = 0.8
xmin = -0.5
xmax = 7.5
plot(slice[,"num.label"],slice[,"CV"],axes = FALSE,#bty="n",
     ylim=c(ymin, ymax),
     xlim=c(xmin, xmax),
     yaxs = "i",xaxs = "i",
     xlab="Strains",ylab="CV",
     cex.lab=2,
     xaxt="n",yaxt='n')

axis(1, pos = 0, lwd = 5,at=c(0.5,1:6), labels=c("","GZ240","GZ241","BY4741","BY4742","bck2","whi5"))
axis(2, pos = 0.5, lwd = 5,lwd.ticks=3,cex.axis = 2)

ymin = 0
ymax = 0.16
xmin = -0.5
xmax = 7.5
plot(slice[,"num.label"],slice[,"logCV"],axes = FALSE,#bty="n",
     ylim=c(ymin, ymax),
     xlim=c(xmin, xmax),
     yaxs = "i",xaxs = "i",
     xlab="Strains",ylab="CV of log(volume)",
     cex.lab=2,
     xaxt="n",yaxt='n')

axis(1, pos = 0, lwd = 5,at=c(0.5,1:6), labels=c("","GZ240","GZ241","BY4741","BY4742","bck2","whi5"))
axis(2, pos = 0.5, lwd = 5,lwd.ticks=3,cex.axis = 2)



