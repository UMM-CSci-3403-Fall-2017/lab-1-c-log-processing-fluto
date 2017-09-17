#!/usr/bin/bash

CONTENTS_FILE=${1}
WRAPPER=${2}
TARGET_FILE=${3}

if [ ! -f "$TARGET_FILE" ]
then	
	touch $TARGET_FILE
fi	

cat "$WRAPPER"_header.html "$CONTENTS_FILE" "$WRAPPER"_footer.html >> "$TARGET_FILE"

