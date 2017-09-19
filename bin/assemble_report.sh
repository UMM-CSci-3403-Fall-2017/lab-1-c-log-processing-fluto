#!/usr/bin/bash

TARGET_DIR=$1

echo -n '' > failed_login_body.html

cat $TARGET_DIR/country_dist.html >> failed_login_body.html 
cat $TARGET_DIR/hours_dist.html >> failed_login_body.html
cat $TARGET_DIR/username_dist.html >> failed_login_body.html

echo -n '' > $TARGET_DIR/failed_login_summary.html

./bin/wrap_contents.sh failed_login_body.html html_components/summary_plots $TARGET_DIR/failed_login_summary.html

rm -f failed_login_body.html
