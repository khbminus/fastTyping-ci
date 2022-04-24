FROM kdeorg/ci-suse-qt62:latest



ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    CC=clang \
    CXX=clang++ \
    AR=llvm-ar \
    RANLIB=llvm-ranlib \
    IROOT=/install

# Nlohmann 
ENV NLOHMANN_ROOT="$IROOT/json/"
RUN git clone https://github.com/nlohmann/json $NLOHMANN_ROOT
WORKDIR $NLOHMANN_ROOT
RUN cmake . -DJSON_BuildTests=OFF && make install
RUN rm -rf $NLOHMANN_ROOT

WORKDIR ~

CMD ["/bin/bash"]
