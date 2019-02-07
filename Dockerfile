# Latest version of centos
FROM rc3labs/ubuntu

MAINTAINER Harvey Cary (hcary@rc3labs.com)

ARG build_num
ARG version
ARG maintainer 
ARG author
ARG company


RUN apt-get update
RUN apt-get install -y software-properties-common 
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible
ADD user-setup.sh /usr/local/bin/user-setup.sh
RUN chmod +x /usr/local/bin/user-setup.sh

ADD chefdk_3.7.23-1_amd64.deb /tmp
RUN apt-get install -y /tmp/chefdk_3.7.23-1_amd64.deb

ENTRYPOINT /usr/local/bin/user-setup.sh
