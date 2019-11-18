#!/usr/bin/perl -w
#parse .#Z2 data files
use strict;

my @files=@ARGV;

my $c=0;
while($files[$c]){
	my $mname="UNKNOWN";
	if ($files[$c]=~m/^(.*)\..*Z2/){
	 $mname = $1;}else{
		 print "$files[$c] is not recognized!"; 
		 $c++;
		 next;}
    my $newname=$mname.".txt";

open (DATA,"$files[$c]")||die "Cannot open file: $files[$c]:$!\n";
open (NEW, ">$newname")||die "Cannot open file: $newname:$!\n";

my $fname  = 'UNKNOWN_FNAME';
my $savedate = 'UNKNOWN_DATE';
my @bins;
my @count;
my $flag = 0;
my $total = 0;
my @mode = (0,0);
my $totalsize=0;


while (<DATA>){
#First parse headers to get date and file info
 s/\r//g;  #remove returns?
 chomp;
 if (m/^Saved=.*\ \s(\d+:.*20\d\d)/){
	 $savedate = $1;
 }
 if (m/^Filename=(.*)\..*Z2/){
	 $fname = $1;
 }

#The file format, after the header info, consists of [#Bindiam], followed by a list of values
#then, [#Binheight], followed by a list of values, one value per line
 $flag = 1 if (m/^\[#Bindiam\]/);
 $flag = 2 if (m/^\[#Binheight\]/);
 #last if (m/^\[end\]/);

 next unless (m/^\ \d/);
 #push (@bins,$_) if ($flag == 1);

 if (($flag == 1) && ($_ =~ m/\d+\.?\d*/) ){ 
 	push (@bins, (4/3 * 3.14159265 * ($_ / 2)**3 ));
 }
 if (($flag == 2) && ($_ =~ m/\d+\.?\d*/) ) {
	push (@count,$_);
	$total += $_;
	$totalsize+=$bins[scalar(@count)-1]*$_;
	if ($mode[1] < $_) {
		$mode[1] = $_;
		$mode[0] = $bins[scalar(@count)-1];
	}
 }

}

#my $mean = sprintf("%.4f",($total / (scalar(@bins) + 1)));
my $mean = sprintf("%.4f",($totalsize / $total));

print STDERR "$savedate $fname ";
print STDERR "@mode $mean\n";
#print "# $savedate $fname\n";
#print "# @mode $mean\n";


for (my $i=0;$i<@bins;$i++){
	##To print all cell volumes:  
	#print NEW "$bins[$i]\n" x $count[$i];
	my $freq=$count[$i]/$total;
	print NEW "$bins[$i]\t$count[$i]\t$freq\n";
	
	##To print histograms
	##print "$bins[$i] ",  ($count[$i]/$total)*100 ," $count[$i]\n";
}
#print "\n";


close NEW;
close DATA;
$c++;
}

exit;