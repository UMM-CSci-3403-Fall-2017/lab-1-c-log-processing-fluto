target_dir=$1

ls $target_dir

echo -n "" > failed_login_data_full.txt

dirs=$target_dir/*
current_dir=$(pwd)

ls $target_dir

for i in $dirs
do
    cat $i/failed_login_data.txt >> $current_dir/failed_login_data_full.txt

done

echo -n '' > temp_login_data.txt

cat failed_login_data_full.txt | awk '{ print $4 }' | sort | uniq -c >> temp_login_data.txt

touch body.html

echo -n '' > body.html

cat temp_login_data.txt

cat temp_login_data.txt | while read line;
do
    loginCount=$(echo $line | awk '{ print $1 }')
    loginUser=$(echo $line | awk '{ print $2 }')
    echo -n "data.addRow(['" >> body.html
    echo -n $loginUser >> body.html
    echo -n "', " >> body.html
    echo -n $loginCount >> body.html
    echo "]);" >> body.html
done

./bin/wrap_contents.sh body.html html_components/username_dist $target_dir/username_dist.html


