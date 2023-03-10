FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

COPY [".", "/usr/src/"]

WORKDIR /usr/src

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        libsndfile-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv \
        && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /venv

RUN /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt

RUN /venv/bin/pip install --no-cache-dir -r ./Wav2Lip/requirements.txt

EXPOSE 8000

CMD ["python", "index.py"]
