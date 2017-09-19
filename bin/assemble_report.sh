#!/usr/bin/bash

TARGET_DIR=$1

# Create a temporary html file before wrapping
echo -n '' > failed_login_body.html

# Write the contents of each of the html files to the temporary file
cat $TARGET_DIR/country_dist.html >> failed_login_body.html 
cat $TARGET_DIR/hours_dist.html >> failed_login_body.html
cat $TARGET_DIR/username_dist.html >> failed_login_body.html

# Create our final html file
echo -n '' > $TARGET_DIR/failed_login_summary.html

# Wrap the contents of our temporary file and move it to the target directory
./bin/wrap_contents.sh failed_login_body.html html_components/summary_plots $TARGET_DIR/failed_login_summary.html

# Clean up
rm -f failed_login_body.html
