#!/bin/bash

# print every url in every file in deb-url-history directory
for f in $(ls deb-url-history/)
do
  zcat "deb-url-history/$f"
done
