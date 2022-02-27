ARG CODE_VERSION=20.04
ARG TF_VERSION=1.1.6
ARG RELEASE="focal"

FROM ubuntu:${CODE_VERSION}
# FROM scratch
# ENV http_proxy http://sub.proxy.att.com:8888/
# ENV https_proxy http://sub.proxy.att.com:8888/
# ENV HTTP_PROXY http://sub.proxy.att.com:8888/
# ENV HTTPS_PROXY http://pxyapp.proxy.att.com:8080/
# ENV no_proxy localhost,127.0.0.1,*.att.com,*.sbc.com,.att.com
# ENV NO_PROXY localhost,127.0.0.1,*.att.com,*.sbc.com,.att.com


# WORKDIR /temp
#RUN    apt-get install -y software-properties-common
#apt-get-add-repository -y ppa:ansible/ansible  && \
# python3-pip python3 lsb-release software-properties-common
# COPY timezone /etc/timezone
RUN apt update -y && \
    apt install zsh git unzip ca-certificates curl gnupg apt-transport-https -y && \
    chsh -s /usr/bin/zsh

WORKDIR /tmp

#
# install Azure CLI lsb-release 
#    AZ_REPO=$(lsb_release -cs) && \
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ focal main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt update -y && \
    apt install azure-cli -y


# 
# Install Terraform
COPY package.tgz /tmp/package.tgz
RUN tar xzvf package.tgz  -C / && \
    cd /usr/local/bin && \
    ln -s terraform-1.1.6 terraform

#
# Install PowerShell
# RUN cd /tmp && \
    # dpkg -i packages-microsoft-prod.deb  && \
    # apt-get install powershell -y

# RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt-get/doc/apt-get-key.gpg && \
#     echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt-get.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt-get/sources.list.d/kubernetes.list && \
#     apt-get update && \
#     apt-get install -y kubectl

WORKDIR /usr/local/bin/
COPY user-setup.sh /usr/local/bin/user-setup.sh
RUN chmod +x /usr/local/bin/user-setup.sh && \
    rm -rf /var/lib/apt-get/lists/*

# #
# # Add AWS command line tools
# #ADD awscli-bundle.zip /tmp
# ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip /tmp/
# WORKDIR /tmp
# RUN unzip awscli-bundle.zip
# WORKDIR /tmp/awscli-bundle
# RUN ./install -i /usr/local/aws -b /usr/local/bin/aws

# WORKDIR /tmp
# ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl /usr/bin/
# RUN chmod +x /usr/bin/kubectl

# ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/darwin/amd64/aws-iam-authenticator /usr/bin/
# RUN chmod +x /usr/bin/aws-iam-authenticator

# ADD https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_Linux_amd64.tar.gz /tmp/
# RUN tar xzvf eksctl_Linux_amd64.tar.gz -C /usr/bin/

# ADD https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip /tmp/
# RUN unzip /tmp/terraform_0.12.6_linux_amd64.zip && mv /tmp/terraform /usr/bin && chmod +x /usr/bin/terraform


ENTRYPOINT /usr/local/bin/user-setup.sh
