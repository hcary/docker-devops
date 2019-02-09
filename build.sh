#!/bin/bash

build_num=`cat build_num.txt`
newnum=`expr $build_num + 1`
echo $newnum >  build_num.txt

export build_num=$newnum

chefdk_ver="3.7.23-1"
chefdk_file="chefdk_${chefdk_ver}_amd64.deb"
chefdk_url="https://packages.chef.io/files/stable/chefdk/${chefdk_ver}/ubuntu/18.04/${chefdk_file}"

if [ ! -e ${chefdk_file} ];
then
    curl ${chefdk_url} -o ${chefdk_file} 
fi



docker build -t rc3labs/ansible . \
    --build-arg "chefdk_file=${chefdk_file}" \
    --label "build=${build_num}" \
    --label "version=1.0" \
    --label "maintainer"="harvey.cary@rc3labs.com" \
    --label "author"="Harvey Cary (hcary@rc3labs.com)" \
    --label "company"="rc3labs.com" 

