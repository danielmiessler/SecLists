#!/bin/sh
#
# SH_KIT
#
# list.sh = Directory & File Listing
#
# by: The Dark Raver
# modified: 16/12/2005
#

echo Content-Type: text/html
echo

if [ "$QUERY_STRING" != "" ]
  then
  echo PATH: $QUERY_STRING "<br><hr>"
  echo `ls $QUERY_STRING` > /tmp/test
  else
  echo PATH: / "<br><hr>"
  echo > /tmp/test
  QUERY_STRING="/"
  root="1"
  fi

out=`grep "/" /tmp/test`

if [ "$out" != "" ]
  then
    echo FICHERO: $QUERY_STRING
    echo "<hr><pre>"
    cat $QUERY_STRING
  else
    if [ "$root" != "1" ]
      then
      echo "( ) <a href=?"$QUERY_STRING"/..>".."</a><br>"
      fi
    for i in `ls $QUERY_STRING`
      do
      if [ "$root" == "1" ] 
        then 
        echo "( ) <a href=?/"$i">"$i"</a><br>"
        else 
        echo "( ) <a href=?"$QUERY_STRING"/"$i">"$i"</a><br>"
        fi
      done

  fi