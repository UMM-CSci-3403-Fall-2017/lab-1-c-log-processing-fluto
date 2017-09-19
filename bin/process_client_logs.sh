target_dir=$1

cd $target_dir

files=var/log/*

echo -n "" > failed_login_data.txt
for i in $files
do
	cat $i | grep "Failed password for" | awk '{ if ($10 =="user") print $1, $2, substr($3, 0, 2), $11, $13; else print $1, $2, substr($3, 0, 2), $9, $11; }' >> failed_login_data.txt
done

