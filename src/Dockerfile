# Latest version of centos
FROM ubuntu:latest

ARG build_num
ARG version
ARG maintainer 
ARG author
ARG company
ARG chefdk_file
ARG python_ver

RUN apt-get update -y
RUN apt-get install -y software-properties-common 
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible git iputils-ping unzip python-pip
RUN apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev python3-pip
RUN pip3 install boto3

#
#
WORKDIR /usr/local/bin/
ADD user-setup.sh /usr/local/bin/user-setup.sh
RUN chmod +x /usr/local/bin/user-setup.sh

#
# Add AWS command line tools
#ADD awscli-bundle.zip /tmp
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip /tmp
WORKDIR /tmp
RUN unzip awscli-bundle.zip
WORKDIR /tmp/awscli-bundle
RUN ./install -i /usr/local/aws -b /usr/local/bin/aws

#
# Install Python3
#ADD ${python_file} /tmp
#WORKDIR /tmp
#RUN tar -xf Python-${python_ver}.tar.xz
#WORKDIR /tmp/Python-${python_ver}
#RUN ./configure --enable-optimizations
#RUN make -j 4
#RUN make altinstall
#RUN ln -s /usr/local/bin/python3.7 /usr/local/bin/python3

COPY bin/* /usr/local/bin/
# 
# Add Kubernetes
#ADD kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/*

#
# Add Chef DK to image
#ADD ${chefdk_file} /tmp
#RUN apt-get install -y /tmp/${chefdk_file}

RUN pip install boto3

ENTRYPOINT /usr/local/bin/user-setup.sh
