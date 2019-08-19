#!/bash


# Retrieve chef developer kit
chefdk_ver="3.7.23-1"
chefdk_file="chefdk_${chefdk_ver}_amd64.deb"
chefdk_url="https://packages.chef.io/files/stable/chefdk/3.7.23/ubuntu/18.04/${chefdk_file}"



if [ ! -e ${chefdk_file} ];
then
    echo "Downloading ${chefdk_url}"
    curl ${chefdk_url} -o ${chefdk_file} 
fi

# Retrieve AWS command line tools
if [ ! -e "awscli-bundle.zip" ];
then
    curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
fi

if [ ! -e "kubectl" ];
then
    curl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/linux/amd64/kubectl -o kubectl
fi

if [ ! -e "eksctl_Linux_amd64.tar.gz" ];
then
    echo "Downloading eksctl_Linux_amd64.tar.gz"
    curl --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_Linux_amd64.tar.gz" -o eksctl_Linux_amd64.tar.gz
fi
echo "Extracting eksctl_Linux_amd64.tar.gz"
tar xzvf eksctl_Linux_amd64.tar.gz -C 

if [ ! -e "mfa.sh" ];
then
    cp ~/mfa.sh 
fi

if [ ! -e "delete-default-vpc.sh" ];
then
    cp delete-default-vpc.sh 
fi

if [ ! -e "aws-iam-authenticator" ];
then
    # https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
    # Linux: https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/linux/amd64/aws-iam-authenticator
    # MacOS: https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/darwin/amd64/aws-iam-authenticator
    # Windows: https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/windows/amd64/aws-iam-authenticator.exe

    curl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/linux/amd64/aws-iam-authenticator -o aws-iam-authenticator
    curl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/linux/amd64/aws-iam-authenticator.sha256 -o aws-iam-authenticator.sha256
    myval=`openssl sha1 -sha256 aws-iam-authenticator | awk '{print $2}'`
    orig=`cat aws-iam-authenticator.sha256 | awk '{print $1}'`

    if [ "$myval" != "$orig" ];
    then
        echo "aws-iam-authenticator sha256 match error..."
        echo "Build aborting..."
        exit
    fi

fi

exit
sudo apt-get update -y
sudo apt-get install -y software-properties-common 
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible git iputils-ping unzip python-pip
 
#
# Add AWS command line tools
#ADD awscli-bundle.zip /tmp
unzip awscli-bundle.zip
cd awscli-bundle
sudo ./install -i /usr/local/aws -b /usr/local/bin/aws

COPY bin/* /usr/local/bin/
# 
# Add Kubernetes
#ADD kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/*

#
# Add Chef DK to image
ADD ${chefdk_file} /tmp
sudo apt-get install -y /tmp/${chefdk_file}

sudo pip install boto3