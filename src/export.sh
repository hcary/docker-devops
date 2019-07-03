#!/bin/sh

export_dt=`date '+%Y%m%d%H%M%S'`
output=${export_dt}-att-devops.tar
image=att/devops

echo "Exporting ${image} to ${output}"
sudo docker image save ${image} -o ${output}

if [ "$1" = "gz" ];
then
	echo "Gzipping ${output}"
	gzip ${export_dt}-att-devops.tar
fi
