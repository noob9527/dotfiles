FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y sudo curl
RUN apt-get install -y python3-dev python3-pip
RUN apt-get install -y python-dev python-pip
RUN pip3 install --upgrade pip
RUN pip install --upgrade pip

COPY . /dotfiles

ENV PATH="/dotfiles/bin:${PATH}"

WORKDIR /dotfiles