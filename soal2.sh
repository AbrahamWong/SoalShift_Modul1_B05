#!/bin/bash

###### 2a
echo "a."
awk -F "," '{ if($7=="2012") {country[$1]+=$10;}}
END{ for(i in country) print i "," country[i];
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -1 | awk -F , '{
print $1}'
echo ""

###### 2b
echo "b."
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
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 | awk -F , '{
print $1}' report2.txt
echo ""

###### 2c
echo "c."
echo "Personal Accessories"
awk -F "," -v A="$a" '
{
	if($7 == "2012" && $1 == A && $4 == "Personal Accessories")
	{
	   prod[$6]+=$10;
	}
}
END{
	for(i in prod)
	 print i "," prod[i]
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 | awk -F "," '{
print $1}'

echo ""
echo "Camping Equipment"
awk -F "," -v A="$a" '
{
        if($7 == "2012" && $1 == A && $4 == "Camping Equipment")
        {
           prod[$6]+=$10;
        }
}
END{
        for(i in prod)
         print i "," prod[i]
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 | awk -F "," '{
print $1}'


echo ""
echo "Outdoor Protection"
awk -F "," -v A="$a" '
{
        if($7 == "2012" && $1 == A && $4 == "Outdoor Protection")
        {
           prod[$6]+=$10;
        }
}
END{
        for(i in prod)
         print i "," prod[i]
}' WA_Sales_Products_2012-14.csv | sort -t "," -k2rn | head -3 | awk -F "," '{
print $1}'
