FROM debian:latest as build

ENV INADYN_VERSION=v2.2

# install deps
RUN apt-get update && \
    apt-get install -y \
    libconfuse-dev \
    pkg-config \
    libtool \
    libssl-dev \
    git \
    automake \
    make \
    autoconf

RUN git clone https://github.com/troglobit/inadyn.git
WORKDIR /inadyn
RUN git checkout ${INADYN_VERSION}
ENV ACLOCAL_PATH=/usr/share/aclocal 
RUN ./autogen.sh \
    && ./configure --enable-openssl --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
    && make

FROM debian:latest
MAINTAINER Justin Garrison <justin@linux.com>

RUN apt-get update \
    && apt-get install -y \
    ca-certificates \
    libssl-dev \
    libconfuse1 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /inadyn/src/inadyn /usr/local/bin/

CMD /usr/local/bin/inadyn
