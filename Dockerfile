FROM ubuntu:bionic
MAINTAINER nikueater <nikueater@outlook.com>

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y g++ git bison flex filepp \
            python-dev \
            libxml2-dev \
            libncurses5-dev \
            unixodbc-dev \
            libomniorb4-dev \
            libreadline-dev \
            wget

WORKDIR /root
RUN git clone https://github.com/vdmtools/vdmtools.git ~/vdmtools && \
	cd ~/vdmtools && \
	git checkout refs/tags/v_9.0.7 -b 9.0.7 && \
    cp ~/vdmtools/code/setup/bashrc.ubuntu ~/.bashrc && \
	. ~/.bashrc
    
RUN mkdir -p /opt && \
    cd /opt && \
    cp ~/vdmtools/code/tools/bin.Linux-x86_64.vdmpp-9.0.7-180126.tar.bz2 /opt && \
    tar xvf ./bin.Linux-x86_64.vdmpp-9.0.7-180126.tar.bz2 && \
	rm -rf ~/vdmtools ~/bin.Linux-x86_64.vdmpp-9.0.7-180126.tar.bz2 

ENV PATH /opt/vdmpp/bin:$PATH

RUN ln -s /usr/lib/x86_64-linux-gnu/libreadline.so /usr/lib/x86_64-linux-gnu/libreadline.so.6

