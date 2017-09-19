target_dir=$1

echo -n "" > failed_login_data_full.txt

dirs=$target_dir/*
current_dir=$(pwd)

for i in $dirs
do
	if [ -f $i/failed_login_data.txt ]
	then
		cat $i/failed_login_data.txt >> $current_dir/failed_login_data_full.txt
	fi
done

echo -n '' > temp_login_data.txt

cat failed_login_data_full.txt | awk '{ print $3 }' | sort | uniq -c >> temp_login_data.txt

touch hours_body.html

echo -n '' > hours_body.html

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

./bin/wrap_contents.sh hours_body.html html_components/hours_dist $target_dir/hours_dist.html

rm -f failed_login_data_full.txt temp_login_data.txt hours_body.html

