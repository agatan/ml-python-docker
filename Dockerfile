FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get -qq update -y \
 && apt-get -qq install -y wget bzip2 \
 && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
 && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
 && rm Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH
WORKDIR /tmp/working

COPY Pipfile /tmp/working/Pipfile
COPY Pipfile.lock /tmp/working/Pipfile.lock

RUN pip install pipenv \
 && pipenv --python /opt/conda/bin/python \
 && pipenv run conda install pytorch \
 && pipenv run conda install torchvision \
 && pipenv install --ignore-pipfile

ARG DISABLE_GPU
RUN [ "$DISABLE_GPU" = "1" ] || pipenv run pip install tensorflow-gpu==1.5.0

ENTRYPOINT ["pipenv", "run"]
