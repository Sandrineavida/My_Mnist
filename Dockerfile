# syntax=docker/dockerfile:1.3

FROM python:3.9-buster

RUN apt -y update
RUN apt install -y --fix-missing \
    build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    pkg-config \
    python3-dev \
    python3-numpy \
    python3-opencv\
    software-properties-common \
    zip \
    && apt clean && rm -rf /tmp/* /var/tmp/*

COPY backend.py backend.py
COPY requirements.txt requirements.txt
COPY mnist.hdf5 mnist.hdf5
RUN --mount=type=cache,target=/root/.cache pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U pip
RUN --mount=type=cache,target=/root/.cache pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

CMD uvicorn backend:app --host 0.0.0.0 --port 8888 
