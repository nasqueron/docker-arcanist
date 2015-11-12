#
# Nasqueron - Arcanist image
#

FROM nasqueron/php-cli
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

#
# Prepare the container
#

RUN apt-get update && apt-get install -y \
            mercurial subversion openssh-client \
            --no-install-recommends && rm -r /var/lib/apt/lists/*
	
RUN cd /opt && \
    git clone https://github.com/phacility/libphutil.git && \
    git clone https://github.com/phacility/arcanist.git && \
    cd /home/app && \
    ln -s /opt/arcanist/bin/arc /usr/local/bin/arc && \
    ln -s /opt/config/gitconfig /root/.gitconfig && \
    ln -s /opt/config/arcrc /root/.arcrc

COPY files /

#
# Docker properties
#

VOLUME ["/opt/config", "/opt/workspace"]
WORKDIR /opt/workspace
CMD ["/usr/local/bin/arc"]
