#!/bin/bash
#to output concordant and disconcordant aligned reads from casc/caunaligned/ and scca/scunaligned
# output total read count from casc or scca
rm *log_summary.txt
for i in ./casc/*.log; do
	echo $i>>total_log_summary.txt
	head -1 $i >> total_log_summary.txt
	# tail -1 $i >> ca_log_summary.txt
done

for i in ./casc/caunaligned/*.log; do
        echo $i>>casc_log_summary.txt
        grep 'aligned concordantly exactly 1 time' $i >> casc_log_summary.txt
        grep 'aligned concordantly >1 times' $i >> casc_log_summary.txt
		grep 'aligned discordantly' $i >> casc_log_summary.txt
done

for i in ./scca/scunaligned/*.log; do
        echo $i>>scca_log_summary.txt
        grep 'aligned concordantly exactly 1 time' $i >> scca_log_summary.txt
        grep 'aligned concordantly >1 times' $i >> scca_log_summary.txt
		grep 'aligned discordantly' $i >> scca_log_summary.txt
done

