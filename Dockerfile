FROM ubuntu:20.04

RUN apt update &&\
    DEBIAN_FRONTEND=nointeractive \
    apt install --no-install-recommends --no-install-suggests -y -qq\
    sudo less openssh-server emacs vim ruby ant make git python3 pip gosu gcc g++ python3-dev patch

RUN DEBIAN_FRONTEND=nointeractive \
    apt install --no-install-recommends --no-install-suggests -y -qq\
    mercurial gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib

COPY requirements.txt inttypes.h.patch /tmp/

ARG LOCAL_UID=1000 LOCAL_GID=1000 LOCAL_USER=ugawa

RUN pip install --system mbed-cli &&\
    pip install --system -r /tmp/requirements.txt &&\
    patch /usr/include/newlib/inttypes.h < /tmp/inttypes.h.patch &&\
    addgroup --gid ${LOCAL_GID} ${LOCAL_USER} &&\
    useradd --home-dir /home/${LOCAL_USER} --shell /bin/bash \
    --create-home -u ${LOCAL_UID} -g ${LOCAL_GID} --groups sudo ${LOCAL_USER}
    
COPY sudoers /etc/sudoers

RUN mkdir /run/sshd
CMD /usr/sbin/sshd -D 
