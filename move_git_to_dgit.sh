#!/bin/bash

files=`find . -name git`
echo $files


for file in $files; do
  new_file=${file%git}.git
  echo file=$file, new_file=$new_file
  mv $file $new_file
done
