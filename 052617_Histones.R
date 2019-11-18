setwd("C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/052317FirstDraft/Figure9")

#par(mfrow=c(2,2))

tonumeric <- function(x){
  a = as.numeric(as.character(x))
  return(a)
}


data = read.csv('121016.csv',sep=',',header=T);
colnames(data);
slopes = apply(data[2:dim(data)[1],c(32:34)],2,tonumeric);
colnames(slopes) = lapply(data[1,c(32:34)],as.character);
rownames(slopes) = data[2:dim(data)[1],12];
cor(slopes[,1:3],use="complete",method = "spearman")


rank.norm = slopes[,1:3];
rank.norm = apply(-rank.norm,2,rank);


HISTONES = c("HTA1","HTA2","HTB1","HTB2","HHT1","HHT2","HHF1","HHF2","HHO1","HTZ1");
slopes = cbind(slopes,matrix(nrow=dim(slopes)[1],ncol=1));
colnames(slopes) = c(colnames(slopes)[1:3],"Histones");

for(gene in row.names(slopes)){
  if(gene %in% HISTONES){
    slopes[gene,4] = 1;
  }
  else{slopes[gene,4] = 0;}

  
}

par(mfrow=c(3,1))
titles = c("gang","yuping1","yuping2");
for(index in 1:3){
  show = slopes[order(slopes[,index],decreasing=T),];
  
  order = order(show[,index],decreasing = T);
  pdf(file = paste(titles[index],".pdf"),width = 14, height = 9)
  plot(order,show[,index],
       xlim = c(-50,7000), ylim = c(-0.5,2),
       yaxs="i",xaxs='i',bty = "l",
       pch=20,cex=2, xlab = '',ylab = '')
  points(order[which(show[,4]==1)],show[which(show[,4]==1),index],
         pch=20,cex=2,col='red', xlab = '',ylab = '')

  
  title(titles[index],ylab="Norm. slope(conc/cell size)",xlab = "Cell size scaling ranking")
  dev.off()
  
}


index=1

rank = rank(-show[,index]);
rank = cbind(rownames(show), rank);
rank[which(rank[,1] %in% c(HISTONES)),];


gang = as.numeric(c("13","66","512","3335","6","536","987","3323","5228","1332","3845","3683","4567","3873","3193","5673"));
yuping1 = as.numeric(c("73","170","2714","2338","50","336","732","4381","1858","2627","4802","1971","4156","3814","4856","5781"));
yuping2 = as.numeric(c("62","84","198","438","1302","1523","3284","3406","4227","4757","4785","4908","5242","5292","5839","6029"));
ranks = cbind(gang,yuping1,yuping2)

cor(ranks[,1:3],use="complete",method = "spearman")

