#!/bin/bash
  for i in `seq 1 20`;
     do
        ns ns-csmacd-lab04.tcl -nn $i -seed 26
        p=$(cat csmacd.tr |grep -c "^r.*\s0..*")
        drop=$(cat csmacd.tr |grep -c "^d")
        gen=$(cat csmacd.tr |grep -c "^+")
        
        #p=0
        #drop=0
        #gen=0
        #~ while read p
        #~ do
			#~ read drop
			#~ read gen
		#~ done <file1	
        #~ # file1
        #read p <file1

        sys_eff=$(echo "${p} * 0.08" |bc)
        thru=$(echo "${p} * 0.8" |bc)
        drop_ratio=$(echo "scale=8;${drop} / ${gen}" |bc)
        drop_per=$(echo "${drop_ratio} * 100" |bc)
        
        echo "$i $thru $sys_eff $drop_per"
     done >overall-stats.txt
