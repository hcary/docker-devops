# Latest version of centos
FROM rc3labs/ubuntu
MAINTAINER Harvey Cary (hcary@rc3labs.com)
RUN apt-get update
RUN apt-get install -y software-properties-common 
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible
ADD user-setup.sh /usr/local/bin/user-setup.sh
RUN chmod +x /usr/local/bin/user-setup.sh
#RUN mv /tmp/mysite/* /var/www/html
#EXPOSE 80
#ENTRYPOINT [ "/usr/sbin/httpd" ]
ENTRYPOINT /usr/local/bin/user-setup.sh
