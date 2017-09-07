target_dir = $1

cd target_dir

for f in pwd
do
    cat f | grep "Failed password for" | awk '{ print $1, $2 }' >> failed_login_data.txt
done

