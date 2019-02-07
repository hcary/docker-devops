#!/bin/bash

MYUSER=$USER
MYUID=`id -u $USER`
DEST=/home/$MYUSER

echo "Loading a container named $USER.$$ from anstra-ansible container..."
echo "User will be: " $MYUSER "with UID: " $MYUID
echo

docker run \
    --name $USER.$$ \
    -e "MYUSER=$MYUSER" \
    -e "MYUID=$MYUID" \
    -it \
    --rm \
    --mount type=bind,src="$(echo $HOME)",dst=/home/"$(echo $USER)" \
    rc3labs/ansible \
    /bin/bash


