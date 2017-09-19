#!/usr/bin/bash

here=$(pwd)

mkdir scratch

for i in "$@"
do
	target_dir=$(echo $i | awk -F/ '{print $2}' | awk -F_ '{print $1}') 
	mkdir scratch/$target_dir
	tar -xzf $i -C scratch/$target_dir
	./bin/process_client_logs.sh scratch/$target_dir	
done


./bin/create_username_dist.sh scratch
./bin/create_hours_dist.sh scratch
./bin/create_country_dist.sh scratch
./bin/assemble_report.sh scratch
mv scratch/failed_login_summary.html $here
rm -rf scratch

