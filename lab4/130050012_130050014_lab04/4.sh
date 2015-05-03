ns ns-csmacd-lab04.tcl -nn 20 -seed 26
cat csmacd.tr | grep -e "^+" -e "^r" -e "^-" > sortedq4
cat sortedq4 | sort -k12 -n >sortedq4step2
line1=""
line2=""
echo -n "" > run20-delay-stats.txt
while read line3
do		
	a=( $line1 )
	b=($line2 )
	c=($line3)
	if [[ ${a[0]} == "-" && ${b[0]} == "+" && ${c[0]} == "r" ]]
	then	
		EnqToDeq=$(echo "${a[1]} - ${b[1]}" |bc)
		DeqToRecv=$(echo "${c[1]} - ${a[1]}" |bc)
		echo "${a[11]}	$EnqToDeq	$DeqToRecv"  >> run20-delay-stats.txt
	fi	
	line1=$line2
	line2=$line3	
done < sortedq4step2
rm sortedq4step2
rm sortedq4
