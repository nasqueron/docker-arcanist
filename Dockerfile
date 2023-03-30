#
# Nasqueron - Arcanist image
#

FROM nasqueron/php-cli
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

#
# Prepare the container
#

ENV GIT_VERSION=2.28.0

RUN apt-get update && apt-get install -y \
            mercurial subversion openssh-client locales clang-format \
            python3 \
            silversearcher-ag \
            shellcheck \
            python3-pip python3-setuptools python3-wheel python3-venv flake8 \
            make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext \
            --no-install-recommends && apt-get remove -y git && rm -r /var/lib/apt/lists/* && \
            wget https://github.com/git/git/archive/v$GIT_VERSION.zip -O git.zip && \
            unzip git.zip && cd git-$GIT_VERSION && make prefix=/usr/local all install

RUN cd /opt && \
    git clone https://github.com/phacility/arcanist.git && \
    git clone https://github.com/vhbit/clang-format-linter.git && \
    git clone https://devcentral.nasqueron.org/source/shellcheck-linter.git && \
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && \
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh && \
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
