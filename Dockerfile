FROM mongo:7.0.2

RUN apt-get update && \
        apt-get -y install  wget curl vim nano git

ENV HOME=/root
WORKDIR /root

RUN wget https://github.com/ShorelineCrypto/cheetahcoin/releases/download/v2.4.0/cheetahcoin_2.4.0_x86_64_linux-gnu.tgz
RUN tar xvfz cheetahcoin_2.4.0_x86_64_linux-gnu.tgz
RUN rm cheetahcoin_2.4.0_x86_64_linux-gnu.tgz

# Installing Node
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN source /root/.bashrc && nvm install 20.9.0
SHELL ["/bin/bash", "--login", "-c"]

RUN git clone  https://github.com/team-exor/eiquidus.git

WORKDIR /root/eiquidus
RUN source /root/.bashrc && export PATH="$PATH:/root/.nvm/versions/node/v20.9.0/bin" && npm install --only=prod
RUN git clone https://github.com/ShorelineCrypto/chtaexplorer.git  chtaexplorer
RUN cp -r chtaexplorer/* .  && cp settings.json-example settings.json
