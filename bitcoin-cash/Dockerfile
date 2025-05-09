FROM ubuntu:18.04 AS builder

RUN apt-get update && apt-get install -y \
ca-certificates \
curl \
&& rm -rf /var/lib/apt/lists/*

ARG 0.31.2

RUN curl https://download.bitcoinabc.org/0.31.2/linux/bitcoin-abc-0.31.2-x86_64-linux-gnu.tar.gz \
| tar xz --wildcards --strip 2 \
*/bin/bitcoind \
*/bin/bitcoin-cli



FROM ubuntu:18.04

# RPC port.
EXPOSE 9332

# P2P port.
EXPOSE 9333

# ZeroMQ port.
EXPOSE 9334

RUN echo 'alias cli="bitcoin-cash-cli -rpcuser=admin -rpcpassword=krausiano"' > /root/.bash_aliases

# Copying required binaries from builder stage.
COPY --from=builder bitcoind  /usr/local/bin/bitcoin-cashd
COPY --from=builder bitcoin-cli /usr/local/bin/bitcoin-cash-cli

# Default config used to initalize datadir volume at first or
# cleaned deploy. It will be restored and used after each restart.
COPY bitcoin-cash.conf /root/default/bitcoin.conf

# Entrypoint script used to init datadir if required and for
# starting bitcoin cash daemon.
COPY entrypoint.sh /root/

# We are using exec syntax to enable graceful shutdown. Check
# http://veithen.github.io/2014/11/16/sigterm-propagation.html.
ENTRYPOINT ["bash", "/root/entrypoint.sh"]
