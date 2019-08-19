ARG  CODE_VERSION=18.04
FROM ubuntu:${CODE_VERSION}



RUN apt-get update -y
RUN apt-get install -y software-properties-common 
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible git iputils-ping unzip python-pip  python3-pip tar unzip python3
# build-essential zlib1g-dev  libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
CMD echo About to install boto3
#RUN pip3 install boto3
RUN pip install boto3

#
#
WORKDIR /usr/local/bin/
ADD user-setup.sh /usr/local/bin/user-setup.sh
RUN chmod +x /usr/local/bin/user-setup.sh

#
# Add AWS command line tools
#ADD awscli-bundle.zip /tmp
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip /tmp/
WORKDIR /tmp
RUN unzip awscli-bundle.zip
WORKDIR /tmp/awscli-bundle
RUN ./install -i /usr/local/aws -b /usr/local/bin/aws

WORKDIR /tmp
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl /usr/bin/
RUN chmod +x /usr/bin/kubectl

ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/darwin/amd64/aws-iam-authenticator /usr/bin/
RUN chmod +x /usr/bin/aws-iam-authenticator

ADD https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_Linux_amd64.tar.gz /tmp/
RUN tar xzvf eksctl_Linux_amd64.tar.gz -C /usr/bin/

ADD https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip /tmp/
RUN unzip /tmp/terraform_0.12.6_linux_amd64.zip && mv /tmp/terraform /usr/bin && chmod +x /usr/bin/terraform


ENTRYPOINT /usr/local/bin/user-setup.sh
