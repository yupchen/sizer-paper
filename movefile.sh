for key in `cat listoffiles`; 
do #echo $key;
files=$(find /media/Seagate\ Expansion\ Drive/ychen/hwftp.novogene.com/C202SC18082114/raw_data/ -name "$key*");
filepair=$(echo "${files//"gz  "/"gz\n"}")
#echo $filepair
while read -r file; do
    output=./"${file//"/media/Seagate Expansion Drive/ychen/hwftp.novogene.com/C202SC18082114/raw_data/"/}"
    #output = ""
    zcat "$file" > "${output%".gz"}"
done <<< "$filepair"

done
