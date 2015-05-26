FROM ubuntu:trusty
MAINTAINER Christian Simon <simon@swine.de>

# Set correct environment variables.
ENV HOME /root

# Install dependencies 
RUN apt-get update && \
    apt-get -y install git-core build-essential pkg-config libtool libevent-dev libncurses-dev zlib1g-dev automake libssh-dev cmake ruby openssh-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# clone & build tmate
RUN git clone https://github.com/nviennot/tmate-slave.git /tmp/tmate-slave && \
    cd /tmp/tmate-slave && \
    ./autogen.sh && \
    ./configure && \
     make && \
     make install && \
     rm -rf /tmp/tmate-slave

# Copy run script
ADD /run.sh /run.sh

# Use a volume for the ssh keys
VOLUME /etc/tmate-slave/keys

# Default port
EXPOSE 2222

CMD ["/bin/bash", "/run.sh"]
