target_dir=$1

cd $target_dir

files=$(pwd)/*

for i in $files
do
    cat $i | grep "Failed password for" | awk '{ print $1, $2 }' >> failed_login_data.txt
done

