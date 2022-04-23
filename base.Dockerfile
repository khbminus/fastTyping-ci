FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends software-properties-common \
    curl wget cmake make pkg-config locales git gcc-10 g++-10 \
    openssl libssl-dev libjsoncpp-dev uuid-dev zlib1g-dev libc-ares-dev\
    postgresql-server-dev-all \ 
    libboost-all-dev python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

RUN apt update && apt install -y \
        clang-12 \
        make \
        cmake \
        clang-format-12 \
        clang-tidy-12 \
        cppcheck \
        libboost-all-dev \
        libc++-12-dev \
        libc++abi-12-dev \
        build-essential \
        libgl1-mesa-dev 

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    CC=clang-12 \
    CXX=clang++-12 \
    AR=gcc-ar-10 \
    RANLIB=gcc-ranlib-10 \
    IROOT=/install

# Nlohmann (TODO: use a package)
ENV NLOHMANN_ROOT="$IROOT/json/"
RUN git clone https://github.com/nlohmann/json $NLOHMANN_ROOT
WORKDIR $NLOHMANN_ROOT
RUN cmake . -DJSON_BuildTests=OFF && make install
RUN rm -rf $NLOHMANN_ROOT

CMD ["/bin/bash"]
