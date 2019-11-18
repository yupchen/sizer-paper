setwd("C:/Users/cyp7c_000/Documents/041819_MCMbinding")

data = read.csv2('101619TFsiteswithTableS6SummaryScalingscores.CSV', sep = ',')
adjustcol = 2
columnnames = colnames(data)
colnames(data) = columnnames

Sites = c(0:4) #6
TF = NULL
MCM = NULL
SCB = NULL
MCB = NULL
SCB_v = NULL
MCB_d = NULL
SCBMCB = NULL
SWI5 = NULL
SCBscr = NULL
MCBscr = NULL
eSCB = NULL

gTF = NULL
gMCM = NULL
gSCB = NULL
gMCB = NULL
gSCB_v = NULL
gMCB_d = NULL
gSCBMCB = NULL
gSWI5 = NULL
gSCBscr = NULL
gMCBscr = NULL


#pdf(file = 'Figure6withSCBTFbindingsites.pdf',width = 14, height = 7)
par(mfrow = c(1,3))
ylimit = matrix(c(-0.1,0.7,-0.035,0.26,-0.018,0.12),ncol=3)
for(experiment in 1:3){
  column = 15+14  ###to select transcription factor to show
  mcmcolumn = 15-4 # mcm = 15+1 MCB = 15-4 note to remove #4 in line
  for(i in Sites){
  SCB[i+1] = median(as.numeric(as.character(data[which(as.numeric(as.character(data[,'SCB']))+as.numeric(as.character(data[,'SCB_v']))==i),experiment+adjustcol])),na.rm=T)
  SCB_v[i+1] = median(as.numeric(as.character(data[which(data[,'SCB_v']==i),experiment+adjustcol])),na.rm=T)
  MCB[i+1] = median(as.numeric(as.character(data[which(as.numeric(as.character(data[,'MCB']))==i),experiment+adjustcol])),na.rm=T)
  MCB_d[i+1] = median(as.numeric(as.character(data[which(data[,'MCB_d']==i),experiment+adjustcol])),na.rm=T)
  SCBMCB[i+1] = median(as.numeric(as.character(data[which(data[,'SCB']+data[,'SCB_v']+data[,'MCB_d']-data[,'MCB']/2==i),experiment+adjustcol])),na.rm=T)
  SWI5[i+1] = median(as.numeric(as.character(data[which(data[,'SWI5']==i),experiment+adjustcol])),na.rm=T)
  SCBscr[i+1] = median(as.numeric(as.character(data[which(data[,'SCBscr']==i),experiment+adjustcol])),na.rm=T)
  MCBscr[i+1] = median(as.numeric(as.character(data[which(data[,'MCBscr']==i),experiment+adjustcol])),na.rm=T)
  TF[i+1] = median(as.numeric(as.character(data[which(data[,column]==i),experiment+adjustcol])),na.rm=T)
  MCM[i+1] = median(as.numeric(as.character(data[which(data[,mcmcolumn]==i),experiment+adjustcol])),na.rm=T)
  

  gSCB[[i+1]] = as.numeric(as.character(data[which(as.numeric(as.character(data[,'SCB']))+as.numeric(as.character(data[,'SCB_v']))==i),experiment+adjustcol]))
  gSCB_v[[i+1]] = as.numeric(as.character(data[which(data[,'SCB_v']==i),experiment+adjustcol]))
  gMCB[[i+1]] = as.numeric(as.character(data[which(as.numeric(as.character(data[,'MCB']))==i),experiment+adjustcol]))
  gMCB_d[[i+1]] = as.numeric(as.character(data[which(data[,'MCB_d']==i),experiment+adjustcol]))
  gSCBMCB[[i+1]] = as.numeric(as.character(data[which(data[,'SCB']+data[,'SCB_v']+data[,'MCB_d']-data[,'MCB']/2==i),experiment+adjustcol]))
  gSWI5[[i+1]] = as.numeric(as.character(data[which(data[,'SWI5']==i),experiment+adjustcol]))
  gSCBscr[[i+1]] = as.numeric(as.character(data[which(data[,'SCBscr']==i),experiment+adjustcol]))
  gMCBscr[[i+1]] = as.numeric(as.character(data[which(data[,'MCBscr']==i),experiment+adjustcol]))
  gTF[[i+1]] = as.numeric(as.character(data[which(data[,column]==i),experiment+adjustcol]))
  gMCM[[i+1]] = as.numeric(as.character(data[which(as.numeric(as.character(data[,mcmcolumn]))==i),experiment+adjustcol]))
  }
  lgSCB = lapply(gSCB, function(x) log(x[!is.na(x)]))
  lgMCB = lapply(gMCB, function(x) log(x[!is.na(x)]))
  lgMCB_d = lapply(gMCB_d, function(x) log(x[!is.na(x)]))
  lgSCBMCB = lapply(gSCBMCB, function(x) log(x[!is.na(x)]))
  lgTF = lapply(gTF, function(x) log(x[!is.na(x)]))
  lgMCM = lapply(gMCM, function(x) log(x[!is.na(x)]))

  plot(c(-1,length(Sites)),ylimit[,experiment],type = 'n',
       xlab = '# of sites in 300bp upstreaming TSS', 
       ylab = 'Size Scaling',
       xaxt="n",yaxt='n',bty="n")
  axis(1, lwd = 5,lwd.ticks=3,cex.axis = 2,at = c( -1, seq(from = 0, to = 8, by = 1)))
  axis(2, lwd = 5,lwd.ticks=3,cex.axis = 2,at = c( seq(from = -1, to = ylimit[,experiment][2]+1,by = 0.025)))

  #lines(Sites,log(SCB), col = 'green')
  #lines(Sites[-4],log(MCB[-4]), col = 'red')
  #lines(Sites,log(SCB_v), col = 'yellow')
  #lines(Sites[-8],log(MCB_d)[-8], col = 'blue')
  #lines(Sites,log(SCBMCB), col = 'black')
  #lines(Sites,log(SWI5), col = 'yellow')
  #lines(Sites,log(SCBscr), col = 'violetred4')
  #lines(Sites,log(MCBscr), col = 'purple')
  
  #points(Sites,log(SCB), col = 'green')
  #points(Sites,log(MCB), col = 'red')
  #lines(Sites,log(SCB_v), col = 'yellow')
  #points(Sites,log(MCB_d), col = 'blue')
  #points(Sites,log(SCBMCB), col = 'black')
  #points(Sites,log(SWI5), col = 'yellow')
  #points(Sites,log(SCBscr), col = 'violetred4',pch = 16)
  #points(Sites,log(MCBscr), col = 'purple', pch = 16)
  
  boxplot(gSCB,    boxwex = 0.2, col = 'red',outline=F,add = T,at = Sites - 0.2,
          xaxt="n",yaxt='n',bty="n",whisklty = 0,staplelty = 0)
  #boxplot(gMCB,    boxwex = 0.2, col = 'green', outline=F, add = T,at = 1:9 ,
  #        xaxt="n",yaxt='n',bty="n",whisklty = 0,staplelty = 0)
  #boxplot(gSCBMCB,    boxwex = 0.2, col = 'blue',outline=F,add = T,at = 1:9 + 0.2,
  #        xaxt="n",yaxt='n',bty="n",whisklty = 0,staplelty = 0)
  boxplot(gTF,    boxwex = 0.2, col = 'blue',outline=F,add = T,at = Sites + 0.2,
          xaxt="n",yaxt='n',bty="n",whisklty = 0,staplelty = 0)
  #boxplot(gMCB,    boxwex = 0.2, col = 'orange',outline=F,add = T,at = Sites,
  #        xaxt="n",yaxt='n',bty="n",whisklty = 0,staplelty = 0)
  boxplot(gMCM,    boxwex = 0.2, col = 'orange',outline=F,add = T,at = Sites,
          xaxt="n",yaxt='n',bty="n",whisklty = 0,staplelty = 0)
  
  
  #for(i in 1:9){
  #  vioplot(gSCB[[i]][!is.na(gSCB[[i]])], col = 'grey80',add = T, at = i-0.2)
  #}
  #boxplot(lgMCB_d,  boxwex = 0.1, col = 'blue',  add = T,at = 1:9 + 0.4)
  #boxplot(lgSCBMCB, boxwex = 0.1, col = 'black', add = T,at = 1:9 + 0.6)
  points(Sites+0.8-1,SCB, col = 'red',lwd=2)
  #points(Sites+1,MCB, col = 'green')
  #points(Sites+1.2,SCBMCB, col = 'blue')
  points(Sites+1.2-1,TF, col = 'blue',lwd=2)
  #points(Sites+1-1,MCB, col = 'orange',lwd=2)
  points(Sites+1-1,MCM, col = 'orange',lwd=2)
  lines(Sites+0.8-1,SCB, col = 'red',lwd=2)
  #lines(Sites[-4]+1,MCB[-4], col = 'green')
  #lines(Sites+1.2,SCBMCB, col = 'blue')
  lines(Sites+1.2-1,TF, col = 'blue',lwd=2)
  #lines(Sites[-4]+1-1,MCB[-4], col = 'orange',lwd=2)
  lines(Sites+1-1,MCM, col = 'orange',lwd=2)

  
   
  #legend('topleft',legend = c('SCB','MCB','SCBMCB'),col = c('red','green','blue'),lwd = 1)
  #legend('topleft',legend = c('SCB','MCB',columnnames[column]),col = c('red','orange','blue'),lwd = 1)
  legend('topleft',legend = c('SCB',columnnames[mcmcolumn],columnnames[column]),col = c('red','orange','blue'),lwd = 1)
  
  
}

#dev.off()

