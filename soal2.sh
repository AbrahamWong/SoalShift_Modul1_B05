#!/bin/bash

cd ~/Downloads

###### 2a
echo "a."
a=$( awk -F "," '{ if($7=="2012") {country[$1]+=$10;}}
END{ for(i in country) print i "," country[i];
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -1 | awk -F , '{
print $1}' )
echo $a

###### 2b
echo "b."
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
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 | awk -F , '{
print $1}'
echo ""

###### 2c
echo "c."
awk -F "," -v A="$a" '
{
	if($7 == "2012" && $1 == A && ($4 == "Personal Accessories" || $4 == "Camping Equipment" || $4 == "Outdoor Protection"))
	{
	   prod[$6]+=$10;
	}
}
END{
	for(i in prod)
	 print i "," prod[i]
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 | awk -F "," '{
print $1}'
