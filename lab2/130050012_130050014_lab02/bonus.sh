cat udp-120k.tr | sort -k12 -n > sorted120k
grep -e "^+.*1\s2\scbr" -e "^-.*1\s2\scbr" -e "^d.*1\s2\scbr" sorted120k > final120k

count="0"
sum="0"
minus="-1"
while read line1
do	
	read line2	
	a=( $line1 )
	b=( $line2 )
	
	if [[ ${b[0]} != "d" ]]
	then
		diff=$(echo "${b[1]} - ${a[1]}" |bc)
		if [[ ${diff:0:1} == "-" ]]
		then
			diff=$(echo "${diff}*${minus}" |bc)
		fi
		sum=$(echo "$sum + $diff" |bc)
		count=$[$count+1]
		echo ${diff} ${b[11]} >> plot_queue.data
		#echo -n ${b[1]} ${a[1]} ${diff}
		#echo 
		
		#sum=$[$sum+$diff]
	fi
			
done < final120k

#echo $sum
count=$(echo $count |bc)
#echo $count
avg=$(echo "scale=5;$sum/$count" |bc)
echo -n "Average queuing delay = " $avg	
echo

grep -e "^r.*1\s2\scbr" -e "^+.*0\s1\scbr" -e "^d.*0\s1\scbr" -e "^d.*1\s2\scbr" sorted120k > final120k
count="0"
sum="0"
while read line1
do	
	read line2	
	a=( $line1 )
	b=( $line2 )
	if [[ ${b[0]} == "r" ]]
	then
		diff=$(echo "${b[1]} - ${a[1]}" |bc)
		sum=$(echo "$sum + $diff" |bc)
		count=$[$count+1]		
		#echo -n ${b[1]} ${a[1]} ${diff}
		#echo 
		
		#sum=$[$sum+$diff]
	fi		
done < final120k
#echo $sum
count=$(echo $count |bc)
#echo $count
avg=$(echo "scale=5;$sum/$count" |bc)
echo -n "Average end to end delay = " $avg	
echo

rm sorted120k
rm final120k

gnuplot bonus.gnu
rm plot_queue.data








	
