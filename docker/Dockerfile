FROM ubuntu:24.04 AS ubu2404                                                            
LABEL maintainer="Francesco Castagnotto <fcastagnotto@linux.com>"

# Upgrade system and Yocto Proyect basic dependencies
RUN apt-get update && apt-get -y upgrade && apt-get -y install gawk wget git-core diffstat unzip texinfo\
 gcc-multilib build-essential chrpath socat cpio python-is-python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping libsdl1.2-dev xterm curl \
  file lz4 zstd

 # Set up locales
RUN apt-get -y install locales apt-utils sudo && dpkg-reconfigure locales && locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.utf8

# Clean up APT when done.
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Replace dash with bash
RUN rm /bin/sh && ln -s bash /bin/sh

# User management
# RUN groupadd build -g 1000
# RUN useradd -ms /bin/bash -p build build -u 1028 -g 1000 && \
#     usermod -aG sudo build && \
#     echo "build:build" | chpasswd
        
FROM ubu2404 AS repo
# Install repo
#RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && chmod a+x /usr/local/bin/repo
RUN apt-get update -y && apt-get install nano vim -y
RUN apt-get install bash-completion

FROM repo AS finish
# Run as build user from the installation path
#ENV YOCTO_INSTALL_PATH "/opt/yocto"
#RUN install -o 1000 -g 1000 -d $YOCTO_INSTALL_PATH
USER ubuntu
#WORKDIR ${YOCTO_INSTALL_PATH}
#ENV YOCTO_RELEASE "rocko"
RUN sed -i 's/#force_color_prompt/force_color_prompt/g' ~/.bashrc
RUN echo "alias build='cd /yocto/ && ./build.sh'" >> ~/.bashrc
RUN echo "alias b='cd /yocto/ && ./build.sh'" >> ~/.bashrc


WORKDIR /yocto
