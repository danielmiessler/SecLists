#!/usr/bin/env bash
## IP Generator list. Use many iterations as you need.
#
#for a in {1..254};do
#    echo "$a.1.1.1"
#    for b in {1..254};do
#        echo "$a.$b.1.1"
#       for c in {1..254};do
#           echo "$a.$b.$c.1"
#           for d in {1..254};do
#               echo "$a.$b.$c.$d"
#           done
#       done
#    done
#done

for a in {1..254};do
    echo "10.10.$a.1" >> IPList.txt # Saving to file
    for b in {1..254};do
        echo "10.10.$a.$b" >> IPList.txt
    done
done