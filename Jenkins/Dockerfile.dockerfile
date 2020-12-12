#Create a base image for the Apache2 server.
FROM ubuntu:20.04

#Install packages needed for ansible to connect and config
RUN apt update
RUN apt -y upgrade
RUN apt-get install -y openssh-server
RUN apt-get install -y openssh-client
RUN apt-get install -y iproute2
RUN apt-get install -y iputils-ping
RUN apt-get install -y python3
Run apt-get install -y python3-pip
#RUN apt install -y build-essential libssl-dev libffi-dev python3-dev
RUN apt install -y nano
#RUN apt install -y software-properties-common
#RUN apt install -y ansible

#Set SSH to start on boot
RUN mkdir /var/run/sshd
RUN echo 'root:Aa015970!' | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
Run sed -i 's/#*PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#*PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
