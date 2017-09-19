#!/usr/bin/bash

TARGET_DIR=$1

rm -f $TARGET_DIR/country_dist.html

touch failed_login_data_full.txt

echo -n '' > failed_login_data_full.txt

DIRS=$TARGET_DIR/*
CURRENT_DIR=$(pwd)

for i in $DIRS
do
	if [ -f $i/failed_login_data.txt ]
	then
		cat $i/failed_login_data.txt >> $CURRENT_DIR/failed_login_data_full.txt
	fi
done

touch country_ip_addresses.txt
touch country_ip_codes.txt
touch country_code_count.txt
touch country_code_body.html

echo -n '' > country_ip_addresses.txt
echo -n '' > country_ip_codes.txt
echo -n '' > country_code_count.txt
echo -n '' > country_code_body.html

cat failed_login_data_full.txt | while read line;
do
	IP_ADDRESS=$(echo $line | awk '{ print $5 }')
	grep "$IP_ADDRESS" etc/country_IP_map.txt | awk '{ print $2 }' >> country_ip_codes.txt
done

cat country_ip_codes.txt | sort | uniq -c >> country_code_count.txt

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

./bin/wrap_contents.sh country_code_body.html html_components/country_dist $TARGET_DIR/country_dist.html

rm -f  failed_login_data_full.txt country_ip_addresses.txt country_ip_codes.txt country_code_count.txt country_code_body.html
