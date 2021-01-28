FROM debian:9-slim
RUN apt-get -y update && apt-get install -y python-rrdtool python-pygame python-scipy python-twisted python-twisted-web python-imaging git make
RUN mkdir /src
WORKDIR /src
RUN cd /src && git clone https://github.com/vertcoin-project/verthash-pospace
WORKDIR /src/verthash-pospace/tiny_sha3
RUN git submodule init
RUN git submodule update
WORKDIR /src/verthash-pospace
RUN make all
RUN python setup.py install
COPY . /src/p2pool-vtc 
WORKDIR /src/p2pool-vtc 
CMD ["python","run_p2pool.py","--testnet","--net","vertcoin"]


