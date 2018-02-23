FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get -qq update -y \
 && apt-get -qq install -y software-properties-common \
 && add-apt-repository ppa:jonathonf/python-3.6 \
 && apt-get -qq update -y \
 && apt-get -qq install -y wget python3.6 libgomp1 python-opencv \
 && rm -rf /var/lib/apt/lists/* \
 && cd /tmp \
 && wget https://bootstrap.pypa.io/get-pip.py \
 && python3.6 get-pip.py \
 && rm /tmp/*

WORKDIR /tmp/working

COPY Pipfile /tmp/working/Pipfile
COPY Pipfile.lock /tmp/working/Pipfile.lock

RUN pip3 install pipenv \
 && pipenv install http://download.pytorch.org/whl/cu90/torch-0.3.1-cp36-cp36m-linux_x86_64.whl \
 && pipenv install torchvision \
 && pipenv install --ignore-pipfile

ARG DISABLE_GPU
RUN [ "$DISABLE_GPU" = "1" ] || pipenv run pip install tensorflow-gpu

ENTRYPOINT ["pipenv", "run"]
