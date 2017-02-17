FROM armhf/python:3.5

VOLUME /config

RUN apt-get update && apt-get install -y \
    cython3 \
    python3-dev \
    python3-pip \
    python3-yaml \
    python3-lxml \
    python3-sphinx \
    python3-setuptools \
    libudev-dev \
    libxslt-dev \
    libxml2-dev \
    net-tools \
    nmap \
    build-essential \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD openzwave.sh .
RUN ./openzwave.sh

RUN pip3 install netdisco
RUN pip3 install psutil
RUN pip3 install speedtest-cli
RUN pip3 install python-mpd2
RUN pip3 install python-nmap
RUN pip3 install sqlalchemy
RUN pip3 install aiohttp_cors
RUN pip3 install homeassistant

WORKDIR /config

CMD ["hass", "--open-ui", "--config", "/config"]

EXPOSE 8123
