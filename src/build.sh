#!/bin/bash

#
#SUB_ver=""
#SUB_file=""
#SUB_url=""
#getDepend ${SUB_file} ${SUB_url}


build_dt=`date '+%Y%m%d%H%M%S'`
build_num=`cat build_num.txt`
newnum=`expr $build_num + 1`
echo $newnum >  build_num.txt
company=att

export build_num=$newnum

function clean {
    #rm -f awscli-bundle.zip kubectl aws-iam-authenticator* ${chefdk_file} mfa.sh eksctl_Linux_amd64.tar.gz
    #rm -rf bin
    cd ..
    rm -rf imgbuild
}

function getDepend {

    if [ ! -f $1 ];
    then
        echo "Downloading ${1}"
        curl $2 -o $1
    else
        echo "Dependancy ${1} found..."
    fi

}

if [ ! -e "imgbuild" ];
then
    mkdir imgbuild
fi
cd imgbuild

cp ../* .

if [ "$1" == "clean" ];
then
    clean 
    exit
fi

if [ ! -e "bin" ];
then
    mkdir bin
fi

# Retrieve chef developer kit
#chefdk_ver="3.7.23-1"
#chefdk_file="chefdk_${chefdk_ver}_amd64.deb"
#chefdk_url="https://packages.chef.io/files/stable/chefdk/3.7.23/ubuntu/18.04/${chefdk_file}"
#getDepend ${chefdk_file} ${chefdk_url} 

#python_ver="3.7.3"
#python_file="Python-${python_ver}.tar.xz"
#python_url="https://www.python.org/ftp/python/${python_ver}/Python-${python_ver}.tar.xz"
#getDepend ${python_file} ${python_url}

awscli_ver=""
awscli_file="awscli-bundle.zip"
awscli_url="https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
getDepend ${awscli_file} ${awscli_url}

kubectl_ver=""
kubectl_file="kubectl"
kubectl_url="https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl "
getDepend ${kubectl_file} ${kubectl_url}
#cp ${kubectl_file} bin/${kubectl_file}

eksctl_ver=""
eksctl_file="eksctl_Linux_amd64.tar.gz"
eksctl_url="https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_Linux_amd64.tar.gz"
getDepend ${eksctl_file} ${eksctl_url}
echo "Extracting eksctl_Linux_amd64.tar.gz"
tar xzvf eksctl_Linux_amd64.tar.gz -C bin/

terraform_ver="0.12.3"
terraform_file="terraform_${TERRAFORM_VER}_linux_amd64.zip"
terraform_url="https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip"
getDepend ${terraform_file} ${terraform_url}

#curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/darwin/amd64/aws-iam-authenticator
aws_iam_authenticator_ver="1.13.7/2019-06-11"
aws_iam_authenticator_file="aws-iam-authenticator"
aws_iam_authenticator_url="https://amazon-eks.s3-us-west-2.amazonaws.com/${aws_iam_authenticator_ver}/bin/linux/amd64/aws-iam-authenticator"
getDepend ${aws_iam_authenticator_file} ${aws_iam_authenticator_url}

#aws_iam_authenticator_ver="1.13.7"
aws_iam_authenticator_sha_file="aws-iam-authenticator.sha256"
aws_iam_authenticator_sha_url="https://amazon-eks.s3-us-west-2.amazonaws.com/${aws_iam_authenticator_ver}/bin/linux/amd64/aws-iam-authenticator.sha256"
getDepend ${aws_iam_authenticator_sha_file} ${aws_iam_authenticator_sha_url}

myval=`openssl sha1 -sha256 aws-iam-authenticator | awk '{print $2}'`
orig=`cat aws-iam-authenticator.sha256 | awk '{print $1}'`

if [ "$myval" != "$orig" ];
then
    echo "aws-iam-authenticator sha256 match error..."
    echo "Build aborting..."
    exit
else
    echo "aws-iam-authenticator sha256 match..."
fi

#if [ ! -e "mfa.sh" ];
#then
#    cp ~/bin/mfa.sh bin/
#fi

#if [ ! -e "bin/delete-default-vpc.sh" ];
#then
#    cp delete-default-vpc.sh bin/
#fi

#sudo pip3 install --upgrade awscli

if [ "$1" == "download" ];
then
    echo ""
    exit
fi

docker build -t ${company}/devops . \
    --build-arg "chefdk_file=${chefdk_file}" \
    --build-arg "python_file=${python_ver}" \
    --label "build"="${build_num}" \
    --label "build date"="${build_dt}" \
    --label "version"="1.0" \
    --label "maintainer"="harvey.cary@${company}.com" \
    --label "author"="Harvey Cary (hcary@${company}.com)" \
    --label "company"="${company}.com" 

sudo docker history ${company}/devops