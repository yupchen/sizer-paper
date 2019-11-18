setwd('C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/122018/combined')
df = read.csv2('111518_Summary_ranks.csv',header = T, sep=",")
expt = df[,c(1:2,7,9:11)]
exptmatrix = data.matrix(expt[,3:6])
smallerthan600 = exptmatrix<600
expt[which(rowSums(smallerthan600)==4),]

greaterthan800 = exptmatrix<600
expt[which(rowSums(smallerthan600)==4),]