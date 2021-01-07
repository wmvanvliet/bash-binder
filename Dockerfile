FROM python:3.7.9-stretch
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

RUN set -x && \
    apt-get update && \
    apt install -y \
        bash-completion \
        dictionaries-common \
        emacs-nox \
        git \
        htop \
        less \
        man-db manpages \
        nano \
        psmisc \
        screen \
        sudo \
        tmux \
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

RUN \
    sudo ln -sf /bin/bash /bin/sh && \
    mkdir .jupyter && \
    echo 'c.NotebookApp.terminado_settings = {"shell_command":"/bin/bash"}' > .jupyter/jupyter_notebook_config.py

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
