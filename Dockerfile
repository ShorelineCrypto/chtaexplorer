FROM mongo:4.2.24

RUN apt-get update && \
        apt-get -y install  wget curl vim nano git

ENV HOME=/root
WORKDIR /root

# Installing Node
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN source /root/.bashrc && nvm install 12.18.4
SHELL ["/bin/bash", "--login", "-c"]

RUN git clone https://github.com/ShorelineCrypto/chtaexplorer.git  chtaexplorer-slc
RUN git clone  https://github.com/iquidus/explorer.git  chtaexplorer
RUN wget https://github.com/ShorelineCrypto/cheetahcoin/releases/download/v2.4.0/cheetahcoin_2.4.0_x86_64_linux-gnu.tgz
RUN tar xvfz cheetahcoin_2.4.0_x86_64_linux-gnu.tgz
RUN rm cheetahcoin_2.4.0_x86_64_linux-gnu.tgz

