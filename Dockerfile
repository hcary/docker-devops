# Latest version of centos
FROM rc3labs/ubuntu

MAINTAINER Harvey Cary (hcary@rc3labs.com)

ARG build_num
ARG version
ARG maintainer 
ARG author
ARG company
ARG chefdk_file

RUN apt-get update
RUN apt-get install -y software-properties-common 
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible git
ADD user-setup.sh /usr/local/bin/user-setup.sh
RUN chmod +x /usr/local/bin/user-setup.sh

ADD ${chefdk_file} /tmp
RUN apt-get install -y /tmp/${chefdk_file}

ENTRYPOINT /usr/local/bin/user-setup.sh
