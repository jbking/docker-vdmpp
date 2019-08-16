FROM ubuntu:bionic
MAINTAINER nikueater <nikueater@outlook.com>
ARG vppver="v_9.0.7"
ARG vppbinver="9.0.7-180126"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y git \
            python-dev \
            libxml2-dev \
            libncurses5-dev \
            unixodbc-dev \
            libomniorb4-dev \
            libreadline-dev \
            libqtgui4

WORKDIR /root
RUN mkdir -p /opt && \
    git clone --depth=1 -b ${vppver} https://github.com/vdmtools/vdmtools.git ~/vdmtools && \
    cp ~/vdmtools/code/setup/bashrc.ubuntu ~/.bashrc && \
    mv ~/vdmtools/code/tools/bin.Linux-x86_64.vdmpp-${vppbinver}.tar.bz2 /opt && \
    cd /opt && \
    tar xvf ./bin.Linux-x86_64.vdmpp-${vppbinver}.tar.bz2 && \
	rm -rf ~/vdmtools && \
    rm -f /opt/bin.Linux-x86_64.vdmpp-${vppbinver}.tar.bz2 

ENV PATH /opt/vdmpp/bin:$PATH
ENV LANG C.UTF-8
ENV QT_GRAPHICSSYSTEM=native

RUN ln -s /usr/lib/x86_64-linux-gnu/libreadline.so /usr/lib/x86_64-linux-gnu/libreadline.so.6
