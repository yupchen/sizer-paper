#!/bin/bash

gunzip ./*.gz

dirr=./scca
mkdir $dirr

for i in *_1.fq; do
        /home/programs/bowtie2/bowtie2-2.1.0/bowtie2 --score-min L,-0.6,-0.6 --phred33 -p 8 --un-conc ${dirr}/scunaligned_${i%_1*}_%.fq -x /home/alisa/projects/ngs/indexes/bowtie2_2.1.0/s_cerevisiae_bowtie2-2.1.0_index -1 ${i} -2 ${i%_1.fq}_2.fq -S ${dirr}/${i%.fq}.sam 2> ${dirr}/${i}'.log'; 
done

for i in ${dirr}/*.sam; do 
	samtools view -bT /home/alisa/projects/ngs/indexes/bowtie2_2.1.0/saccharomyces_cerevisiae_R64-1-1_20110208.fa ${i} > ${i%sam}bam; 
done


for i in ${dirr}/*.bam; do 
	samtools sort ${i} ${i%.bam}_sorted; 
done

for i in ${dirr}/*_sorted.bam; do 
	samtools index ${i}; 
done

mkdir ${dirr}/scunaligned
mv ${dirr}/scunaligned_* ${dirr}/scunaligned

#!/bin/bash
clear 
echo "Hello, $USER:"
echo "This is `uname -s` running on a `uname -m` processor:"
echo "    Number of cores: `cat /proc/cpuinfo | grep processor | wc -l`"
echo "    RAM: `grep MemTotal /proc/meminfo | awk '{print $2}' -` kb "

dirr=./scca/scunaligned
for f in ${dirr}/*.fq; do 

	if [[ $f == *_2* ]]; then
		continue
	fi
	
	sample=${f%%_1*}        # delete longest match from the end of the string	
	sample=${sample#${dirr}/}   # delete short match from the front of the string
	r1=${f%_1*}'_1'${f#*_1}
	r2=${f%_1*}'_R2'${f#*_1}
	
	echo	
	echo "###### Processing $sample ######"
	
	# Bowtie local alignment
	/home/programs/bowtie2/bowtie2-2.1.0/bowtie2 -p 12 -x ~/genomes/candida_genome/C_albican_SC5314 -1 $r1 -2 $r2 -S ${dirr}/$sample'.sam' 2> ${dirr}/$sample'.log'

	samtools view -bS ${dirr}/$sample'.sam' | samtools sort - ${dirr}/$sample'_sorted'
	samtools index ${dirr}/$sample'_sorted.bam' ${dirr}/$sample'_sorted.bai'
	
done
