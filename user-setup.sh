#!/bin/bash

if [ "$MYUSER" == "" ]; then
    echo "No user specified, No user will be created..."
    /bin/bash
else
    adduser -q --gecos "" --disabled-password $MYUSER -u $MYUID
    #adduser -m -p * -s /bin/bash $MYUSER -u $MYUID
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    su - $MYUSER 
fi