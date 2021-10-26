#!/bin/sh 

#Check if shunit is present
SHUNIT=./shunit2/shunit2
if test -f "$SHUNIT" ; then
    exit $?
fi

# If shunit is not present we download it. 
curl -L https://github.com/kward/shunit2/archive/refs/tags/v2.1.8.zip -o shunit.zip
unzip shunit.zip -d shunit2
mv shunit2/shunit2-*/* shunit2/
rm -rf shunit2/shunit2-*

