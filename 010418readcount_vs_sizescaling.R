setwd('C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/122018/combined')
df = read.csv2("011619_Summary.csv",sep=',')
dt = df[c('Elute_Expt.1_Rank','Median_Read_Count_in_Elute_Expt.1')]
DF = cbind(as.numeric(as.character(dt[,1])),as.numeric(as.character(dt[,2])))
DF = DF[complete.cases(DF), ]
DF = DF[order(DF[,1]),]
x = DF[,1]
y = DF[,2]
plot(x,y)
f <- rep(1/100,100)
f
#>  [1] 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905
#>  [8] 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905
#> [15] 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905 0.04761905
#y_sym <- filter(y, f, sides=2)
#sequence = seq(from = 50, to = length(x),by = 100)
#plot(x[sequence], y_sym[sequence], col="blue")

sequence = seq(from = 1, to = length(x),by = 100)
#y_median = c()
for(i in sequence){
  #print(i)
  #y_median = append(y_median, mean(y[i:i+100]))
  print(median(y[seq(i,i+100)]))
}

