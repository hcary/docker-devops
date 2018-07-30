#!/bin/bash

if [ "$MYUSER" == "" ]; then
    echo "No user specified, No user will be created..."
    /bin/bash
else
    adduser $MYUSER -u $MYUID
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    su - $MYUSER 
fi