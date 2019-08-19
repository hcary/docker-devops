#!/bin/bash

#
#SUB_ver=""
#SUB_file=""
#SUB_url=""
#getDepend ${SUB_file} ${SUB_url}


build_dt=`date '+%Y%m%d%H%M%S'`
build_num=`cat build_num.txt`
newnum=`expr $build_num + 1`
echo $newnum >  build_num.txt
company=att

export build_num=$newnum

#    --build-arg "chefdk_file=${chefdk_file}" \
#    --build-arg "python_file=${python_ver}" \

sudo docker build -t ${company}/devops . \
    --label "build"="${build_num}" \
    --label "build date"="${build_dt}" \
    --label "version"="1.0" \
    --label "maintainer"="harvey.cary@${company}.com" \
    --label "author"="Harvey Cary (hcary@${company}.com)" \
    --label "company"="${company}.com" 

sudo docker history ${company}/devops