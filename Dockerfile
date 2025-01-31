FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

ARG MYUSER=pritam

RUN apt-get update \
    && apt-get install -y \
       sudo \
       man-db \
       less \
       manpages-dev \
       manpages \
       vim \
       bash-completion \
    && rm -rf /var/lib/apt/lists/* 

# Create new user
RUN useradd -m -s /bin/bash $MYUSER

# Optionally, add the user to the sudoers file (if you want the user to have sudo privileges)
RUN echo "$MYUSER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$MYUSER

# Copy and run unminimize script. Did not find that script in minimized docker image of ubuntu
COPY ./unminimize /usr/local/bin/unminimize
RUN chmod u+x /usr/local/bin/unminimize
RUN unminimize

USER $MYUSER
WORKDIR /home/$MYUSER
