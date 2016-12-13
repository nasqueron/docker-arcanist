#
# Nasqueron - Arcanist image
#

FROM nasqueron/php-cli
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

#
# Prepare the container
#

RUN apt-get update && apt-get install -y \
            mercurial subversion openssh-client locales clang-format-3.5 \
            --no-install-recommends && rm -r /var/lib/apt/lists/* && \
    ln -s /usr/bin/clang-format-3.5 /usr/bin/clang-format && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

RUN cd /opt && \
    git clone https://github.com/phacility/libphutil.git && \
    git clone https://github.com/phacility/arcanist.git && \
    git clone https://github.com/vhbit/clang-format-linter.git && \
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && \
    cd /home/app && \
    ln -s /opt/arcanist/bin/arc /usr/local/bin/arc && \
    ln -s /opt/config/gitconfig /root/.gitconfig && \
    ln -s /opt/config/arcrc /root/.arcrc

COPY files /

#
# Docker properties
#

ENV LANG en_US.UTF-8
VOLUME ["/opt/config", "/opt/workspace"]
WORKDIR /opt/workspace
CMD ["/usr/local/bin/arc"]
