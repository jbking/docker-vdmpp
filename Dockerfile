FROM ubuntu:bionic
MAINTAINER nikueater <nikueater@outlook.com>

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y g++ git bison flex filepp \
            python-dev \
            libxml2-dev libncurses5-dev \
            unixodbc-dev \
            libreadline-dev \
            wget

WORKDIR /root
RUN git clone https://github.com/vdmtools/vdmtools.git ~/vdmtools && \
	cd ~/vdmtools && \
	git checkout refs/tags/v_9.0.7 -b 9.0.7
	
WORKDIR /root
RUN cp ~/vdmtools/code/setup/bashrc.ubuntu ~/.bashrc && \
	. ~/.bashrc
    
WORKDIR /root
RUN cp ~/vdmtools/code/tools/bin.Linux-x86_64.vdmpp-9.0.7-180126.tar.bz2 ~/ && \
    tar xvf ~/bin.Linux-x86_64.vdmpp-9.0.7-180126.tar.bz2 && \
	rm -rf ~/vdmtools ~/bin.Linux-x86_64.vdmpp-9.0.7-180126.tar.bz2 && \
	echo 'export PATH=/root/vdmpp/bin:$PATH' >> ~/.bashrc && \
	. ~/.bashrc

WORKDIR /root
RUN wget https://sourceforge.net/projects/omniorb/files/omniORB/omniORB-4.2.1/omniORB-4.2.1-2.tar.bz2/download -O omniORB-4.2.1.tar.bz2 && \
	tar xvf omniORB-4.2.1.tar.bz2 && \
	cd omniORB-4.2.1 && \
	./configure --prefix=/usr/local/omniORB && \
	make && \
	make install && \
	cd ~ && \
	rm -rf omniORB-4.2.1.tar.bz2 omniORB-4.2.1

RUN ln -s /usr/lib/x86_64-linux-gnu/libreadline.so /usr/lib/x86_64-linux-gnu/libreadline.so.6

ENTRYPOINT ["bash"]
