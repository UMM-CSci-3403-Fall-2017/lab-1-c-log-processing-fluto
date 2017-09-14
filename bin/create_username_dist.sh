target_dir=$1

ls $target_dir

echo "" > failed_login_data_full.txt

dirs=$target_dir/*
current_dir=$(pwd)

ls $target_dir

for i in $dirs
do
    cat $i/failed_login_data.txt >> $current_dir/failed_login_data_full.txt

done

echo '' > temp_login_data.txt

cat failed_login_data_full.txt | awk '{ print $4 }' | sort | uniq -c >> temp_login_data.txt

touch username_dist.html

echo '' > username_dist.html

cat temp_login_data.txt

cat temp_login_data.txt | while read line;
do
    ##echo $line | awk -v line_1='{ print $1 }', line_2='{ print $2 }'
    echo $line | awk '{ print $2 }' | 
    echo "data.addRow([\x27$line_2\x27, $line_1]);" >> username_dist.html
    #echo $line | awk -v line_1="$1", line_2="$2" '{ print "data.addRow([\x27line_2\x27, line_1]);" }' >> username_dist.html
done
