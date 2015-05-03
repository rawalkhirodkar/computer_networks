cat udp-160k.tr | sort -k12 -n > sorted160k
grep -e "^r.*1\s2\scbr" -e "^+.*0\s1\scbr" -e "^d.*0\s1\scbr" -e "^d.*1\s2\scbr" sorted160k > final160k

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
done < final160k
#echo $sum
count=$(echo $count |bc)
#echo $count
avg=$(echo "scale=5;$sum/$count" |bc)
echo -n "Average end to end delay = " $avg	
echo
rm sorted160k
rm final160k
