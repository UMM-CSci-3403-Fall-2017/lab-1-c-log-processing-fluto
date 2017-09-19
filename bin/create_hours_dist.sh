#!/usr/bin/bash

target_dir=$1

# Create the temporary file to store the contents of all failed_login_data.txt files
echo -n "" > failed_login_data_full.txt

# Get the subdirectories from the target directory
dirs=$target_dir/*
current_dir=$(pwd)

# Add all of the failed_login_data.txt files to our temporary file
for i in $dirs
do
	if [ -f $i/failed_login_data.txt ]
	then
		cat $i/failed_login_data.txt >> $current_dir/failed_login_data_full.txt
	fi
done

# Create the temporary file to store the filtered data from our failed_login_data_full.txt file
echo -n '' > temp_login_data.txt

# Add the filtered data
cat failed_login_data_full.txt | awk '{ print $3 }' | sort | uniq -c >> temp_login_data.txt

# Create a temporary html file
echo -n '' > hours_body.html

# Write the html dataAddRow's to the temporary html file
cat temp_login_data.txt | while read line;
do
    loginCount=$(echo $line | awk '{ print $1 }')
    loginHour=$(echo $line | awk '{ print $2 }')
    echo -n "data.addRow(['" >> hours_body.html
    echo -n $loginHour >> hours_body.html
    echo -n "', " >> hours_body.html
    echo -n $loginCount >> hours_body.html
    echo "]);" >> hours_body.html
done

# Wrap the contents
./bin/wrap_contents.sh hours_body.html html_components/hours_dist $target_dir/hours_dist.html

# Clean up
rm -f failed_login_data_full.txt temp_login_data.txt hours_body.html

