#!/bin/bash

if [ ! -e chefdk_3.7.23-1_amd64.deb ];
then
    curl https://packages.chef.io/files/stable/chefdk/3.7.23/ubuntu/18.04/chefdk_3.7.23-1_amd64.deb -o chefdk_3.7.23-1_amd64.deb 
fi

build_num=`cat build_num.txt`
newnum=`expr $build_num + 1`
echo $newnum >  build_num.txt

export build_num=$newnum


docker build -t rc3labs/ansible . \
 --label "build=${build_num}" \
 --label "version=1.0" \
 --label "maintainer"="harvey.cary@rc3labs.com" \
 --label "author"="Harvey Cary (hcary@rc3labs.com)" \
 --label "company"="rc3labs.com" 

