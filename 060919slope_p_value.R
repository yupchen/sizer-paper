library("smatr")
setwd('C:/Users/cyp7c_000/Documents/060919slope_pvalue')

input = c('gang.csv','Elu_Expt2.csv','Elu_Expt3.csv','Elu_ctrl.csv','Inh_Expt.csv','Elu_ctrl.csv')
output = c('Elu_Expt_p.csv','Elu_Expt2_p.csv','Elu_Expt3_p.csv','Elu_ctrl_p.csv','Inh_Expt_p.csv','Inh_ctrl_p.csv')
for( i in 1:length(input)){
file = read.csv2(input[i],sep=',',header = F,stringsAsFactors = F)
sample_num = dim(file)[2]-2
sizes = as.numeric(file[1,1:sample_num+2])
df = cbind(file,0)
for(gene in 3:dim(file)[1]){
  df[gene,sample_num+3] = slope.test(as.numeric(file[gene,1:sample_num+2]),sizes ,test.value = 0,intercept = F,method = 'OLS')$p
}
write.table(df, file = output[i],sep=',')
}

###
library('metap')
file = read.csv2('060919_slope_p_summary.csv',sep=',',header = T, stringsAsFactors = F)
expt_num = dim(file)[2]-2
df = cbind(file,0)
df = cbind(df,0)
for(gene in 1:dim(file)[1]){
  try({df[gene,expt_num+3] = as.numeric(sumz(as.numeric(file[gene,3:6]),na.action = na.omit)[2])})
  try({df[gene,expt_num+4] = as.numeric(sumz(as.numeric(file[gene,7:8]),na.action = na.omit)[2])})
  
}

for(gene in 1:dim(file)[1]){
  try(if(df[gene,expt_num+3]==0){df[gene,expt_num+3] = as.numeric(df[gene,which(!is.na(as.numeric(df[gene,3:6])))+2])})
  try(if(df[gene,expt_num+4]==0){df[gene,expt_num+4] = as.numeric(df[gene,which(!is.na(as.numeric(df[gene,7:8])))+6])})
}

#df[which(df[,expt_num+3]==0),expt_num+3] = sum(df[which(df[,expt_num+3]==0),3:6],na.rm = T)
#df[which(df[,expt_num+4]==0),expt_num+4] = mean(df[which(df[,expt_num+4]==0),7:8],na.rm = T)
#nadf1 = df[which(df[,expt_num+3]==0),3:6]
#df[which(df[,expt_num+3]==0),expt_num+3] = as.matrix(nadf1)[which((nadf1[,]=="<NA>")=="FALSE")]
#nadf2 = df[which(df[,expt_num+4]==0),7:8]
#df[which(df[,expt_num+4]==0),expt_num+4] = as.matrix(nadf2)[which((nadf2[,]=="<NA>")=="FALSE")]

write.table(df, file = '061019_combined_splope_p.csv',sep=',')
