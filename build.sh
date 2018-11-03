#!/bin/bash

build_num=`cat build.num`
newnum=`expr $build_num + 1`
echo $newnum >  build.num

export build_num=$newnum


docker build -t rc3labs/ansible . \
 --label "build=${build_num}" \
 --label "version=1.0" \
 --label "maintainer"="harvey.cary@rc3labs.com" \
 --label "author"="Harvey Cary (hcary@rc3labs.com)" \
 --label "company"="rc3labs.com" 

