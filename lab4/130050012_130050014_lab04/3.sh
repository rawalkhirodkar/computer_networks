#!/bin/bash
	ns ns-csmacd-lab04.tcl -nn 20 -seed 26
  for i in `seq 1 20`;
     do
        p=$(cat csmacd.tr |grep -c "^r.*$i.0\s0..*")

        thru=$(echo "${p} * 0.8" |bc)
        
        echo "$i $thru"
     done >run20-node-stats.txt
