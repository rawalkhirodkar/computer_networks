#!/usr/bin/awk -f
BEGIN{ 
count=0;
avDelayNum=0;
}
{
	if($1 == "+" && $3 == "1" && $4 == "2") {
		delay[$12] = $2;
	}
	else if($1 == "-" && $3 == "1" && $4 == "2") {
		if ($12 in delay){
			avDelayNum = avDelayNum + $2 - delay[$12];
			count++;
			print $11,($2 - delay[$12]);
		}
	}

	
}
END{
}
