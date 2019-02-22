#!/bin/bash

#######2a
awk -F "," '{ if($7=="2012") {country[$1]+=$10;}}
END{ for(i in country) print i "," country[i];
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -1 > report1.txt
echo "a."
cat report1.txt

#######2b
a=`awk -F "," '{print $1}' report1.txt`
awk -F "," -v A="$a" '
{
	if($7 == "2012" && $1 == A)
	{
	  prod_line[$4]+=$10;
	}
}
END{
	for(i in prod_line)
	 print i "," prod_line[i];
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 > report2.txt
echo "b."
cat report2.txt

#######2c
#####	masih salah
awk -F "," -v A="$a" '
{
	if($7 == "2012" && $1 == A)
	{
	   prod[$6]+=$10;
	}
}
END{
	for(i in prod)
	 print i "," prod[i]
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 > report3.txt
echo "c."
cat report3.txt
