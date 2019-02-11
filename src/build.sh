#!/bin/bash

build_dt=`date '+%Y%m%d%H%M%S'`
build_num=`cat build_num.txt`
newnum=`expr $build_num + 1`
echo $newnum >  build_num.txt
company=rc3labs

export build_num=$newnum

chefdk_ver="3.7.23-1"
chefdk_file="chefdk_${chefdk_ver}_amd64.deb"
chefdk_url="https://packages.chef.io/files/stable/chefdk/3.7.23/ubuntu/18.04/${chefdk_file}"


if [ ! -e ${chefdk_file} ];
then
    echo "Downloading ${chefdk_url}"
    curl ${chefdk_url} -o ${chefdk_file} 
fi


docker build -t ${company}/devops . \
    --build-arg "chefdk_file=${chefdk_file}" \
    --label "build"="${build_num}" \
    --label "build date"="${build_dt}" \
    --label "version"="1.0" \
    --label "maintainer"="harvey.cary@${company}.com" \
    --label "author"="Harvey Cary (hcary@${company}.com)" \
    --label "company"="${company}.com" 

