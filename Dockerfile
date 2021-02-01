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
#       manpages \
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

#
# SPOILERS AHEAD!!!
#
#
#
# Start hiding flags.
#
#
#
# Really, look away if you don't want to spoil the game
#
#
#
#
#
#
#
#
RUN echo 'You found the first flag! Great start. To find the next flag, you must leave the safety of your HOME dir and go somewhere suspicious looking.' > ${HOME}/flag1

RUN mkdir ${HOME}/suspicious_subdir
RUN echo 'You found the second flag! You are on a roll! To find the next flag, you must inspect your environment closely' > ${HOME}/suspicious_subdir/flag2

ENV flag3 "You found the third flag! The next flag is cleverly hidden in your HOME dir, and you never even noticed, bwahahahah!"

RUN echo "You found the fourth flag! To find the next flag, you must read George Orwell's classic distopian novel. Have fun!" > ${HOME}/.flag4

RUN wget http://gutenberg.net.au/ebooks01/0100021.txt -O ${HOME}/tmp.txt
RUN sed '8746iflag5: You have found the fifth flag! The next flag is in buried in ~/bin/garbage' ${HOME}/tmp.txt > ${HOME}/George_Orwell_1984.txt
RUN rm ${HOME}/tmp.txt

RUN mkdir ${HOME}/bin
RUN dd if=/dev/random bs=1024 count=1024 > ${HOME}/bin/garbage
RUN echo "flag6: You have found the sixth flag! The next flag is running as a background process." >> ${HOME}/bin/garbage
RUN dd if=/dev/random bs=1024 count=1024 >> ${HOME}/bin/garbage

# Run the startup script
RUN wget https://raw.githubusercontent.com/wmvanvliet/bash-binder/hideandseek/flag7 -O /tmp/flag7
RUN wget https://raw.githubusercontent.com/wmvanvliet/bash-binder/hideandseek/startup.sh -O /tmp/startup.sh
ENTRYPOINT ["bash", "/tmp/startup.sh"]
