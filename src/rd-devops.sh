#!/bin/bash

if [ "$SUDO_USER" != "" ];
then
    MYUSER=$SUDO_USER
    MYUID=`id -u $SUDO_USER`
else
    MYUSER=$USER
    MYUID=`id -u $USER`
fi

DEST=/home/$MYUSER
company=att

echo "Loading a container named $USER.$$ from anstra-ansible container..."
echo "User will be: " $MYUSER "with UID: " $MYUID
echo

sudo docker run \
    --name $USER.$$ \
    --hostname "devops" \
    -e "MYUSER=$MYUSER" \
    -e "MYUID=$MYUID" \
    -it \
    --rm \
    --mount type=bind,src="$(echo $HOME)",dst=/home/"$(echo $USER)" \
    grc/devops \
    /bin/bash


