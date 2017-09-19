#!/usr/bin/bash

TARGET_DIR=$1

#rm -f $TARGET_DIR/country_dist.html

# Create the temporary file to store the contents of all failed_login_data.txt files
echo -n '' > failed_login_data_full.txt

# Get the subdirectories from the target directory
DIRS=$TARGET_DIR/*
CURRENT_DIR=$(pwd)

# Add all of the failed_login_data.txt files to our temporary file
for i in $DIRS
do
	if [ -f $i/failed_login_data.txt ]
	then
		cat $i/failed_login_data.txt >> $CURRENT_DIR/failed_login_data_full.txt
	fi
done

# Create temporary files 
echo -n '' > country_ip_codes.txt
echo -n '' > country_code_count.txt
echo -n '' > country_code_body.html

# Map ip addresses to country codes
cat failed_login_data_full.txt | while read line;
do
	IP_ADDRESS=$(echo $line | awk '{ print $5 }')
	grep "$IP_ADDRESS" etc/country_IP_map.txt | awk '{ print $2 }' >> country_ip_codes.txt
done

# filter and count the occurances of each country code
cat country_ip_codes.txt | sort | uniq -c >> country_code_count.txt

# Write the html dataAddRow's to the temporary html file
cat country_code_count.txt | while read line;
do
	COUNTRY_CODE_COUNT=$(echo $line | awk '{ print $1 }')
	COUNTRY_CODE=$(echo $line | awk '{ print $2 }')
	echo -n "data.addRow(['" >> country_code_body.html
    	echo -n $COUNTRY_CODE >> country_code_body.html
    	echo -n "', " >> country_code_body.html
    	echo -n $COUNTRY_CODE_COUNT >> country_code_body.html
    	echo "]);" >> country_code_body.html
done

# Wrap the contents
./bin/wrap_contents.sh country_code_body.html html_components/country_dist $TARGET_DIR/country_dist.html

# Clean up 
rm -f  failed_login_data_full.txt country_ip_codes.txt country_code_count.txt country_code_body.html
