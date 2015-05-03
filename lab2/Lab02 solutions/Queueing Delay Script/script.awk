#!/usr/bin/awk -f
BEGIN{ 
count=0;
avDelayNum=0;
}
{
	avDelayNum = avDelayNum + $2;
	count++;

	
}
END{
print "average Queueing Delay ", avDelayNum/count;
}
