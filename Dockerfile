FROM python:3.7.9-stretch
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

RUN set -x && \
    apt-get update && \
    apt install -y \
        bash-completion \
        emacs-nox \
        git \
        less \
        man-db manpages \
        nano \
        sudo \
        vim-tiny \
    && \
    apt-get clean  &&  rm -r /var/lib/apt/lists/*

RUN pip install bash_kernel

# This is not needed for stretch-based images
#RUN rm -f /etc/dpkg/dpkg.cfg.d/excludes
#RUN yes | unminimize && \
#    apt-get install -y \
#        man-db \
#	manpages \
#        && \
#    rm -r /var/lib/apt/lists/*

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}

ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
