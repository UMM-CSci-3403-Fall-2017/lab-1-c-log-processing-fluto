#!/usr/bin/bash

# Get the project directory
here=$(pwd)

# Make our scratch directory for working in
mkdir scratch

# Create a directory for each compressed file, then extract the contents into that directory. 
# Call process_client_logs to create the failed_login.txt files in each of the newly created directories.
for i in "$@"
do
	target_dir=$(echo $i | awk -F/ '{print $2}' | awk -F_ '{print $1}') 
	mkdir scratch/$target_dir
	tar -xzf $i -C scratch/$target_dir
	./bin/process_client_logs.sh scratch/$target_dir	
done

# Call the remaining html generating scripts and move the resulting file to the project directory.
./bin/create_username_dist.sh scratch
./bin/create_hours_dist.sh scratch
./bin/create_country_dist.sh scratch
./bin/assemble_report.sh scratch
mv scratch/failed_login_summary.html $here

# Clean up
rm -rf scratch

