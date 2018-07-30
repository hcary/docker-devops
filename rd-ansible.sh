#!/bin/bash

MYUSER=$USER
MYUID=`id -u $USER`
echo "Loading a container named $USER.$$ from anstra-ansible container..."
echo "User will be: " $MYUSER "with UID: " $MYUID
echo

sudo docker run --name $USER.$$ -e "MYUSER=$MYUSER" -e "MYUID=$MYUID" -i -t -v /home/$USER:/home/$USER astra-ansible /bin/bash 
