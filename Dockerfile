# Dockerfile
FROM ubuntu:22.04

# 1. Instalar dependencias de compilación
RUN apt-get update && apt-get install -y \
    build-essential autoconf automake libtool pkg-config \
    libssl-dev libboost-all-dev libdb++-dev ca-certificates git \
  && rm -rf /var/lib/apt/lists/*

# 2. Clonar el código
WORKDIR /opt
RUN git clone https://github.com/cool-pool/multialgo-mining-pool.git

# 3. Compilar
WORKDIR /opt/multialgo-mining-pool
RUN ./autogen.sh && ./configure --prefix=/usr && make && make install

# 4. Exponer puertos RPC y P2P
EXPOSE 8332 8333

# 5. Punto de entrada
ENTRYPOINT ["bitcoind"]
CMD ["-printtoconsole"]
