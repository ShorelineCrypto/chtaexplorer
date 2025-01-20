# How to Setup Explorer for Cheetahcoin (CHTA) 

This guide explains step by step at high level to self host an explorer for Cheetahcoin (CHTA) in a linux server with docker / docker-compose installed.

The explorer runs with mongodb that also needs about 4G of disk for storing the blockchain content in its database plus full node disk requirement of 3G. 

## Example of Working CHTA Explorer

http://chtaexplorer.mooo.com:3002/

## Explorer software

The chtaexplorer is powered in its engine by open sourced software eIquidus inside docker container. The eIqidus explorer github can be found at:
https://github.com/team-exor/eiquidus

eIquidus github documentation has tons of instructions to configure mongodb and explorer software. The chtaexplorer has automated most of steps with docker method.
You can follow documentation for understanding docker setup steps or run the same software without docker. 

#### git clone chtaexplorer, prepare host folders

Docker shares several volumes between host and container. The mongodb database folder is cross mounted from user home directory "chtaexplorerdb" while "mongo_backup"
is mounted as container backup folder for mongo backup operations. Host machine from user home directory ".cheetahcoin" folder is cross mounted inside container for running full node. 

```
  cd ~
  git clone https://github.com/ShorelineCrypto/chtaexplorer.git
  mkdir chtaexplorerdb mongo_backup .cheetahcoin

```

#### build docker image and start container

You can pull a public docker image with below command:

```
  docker pull shorelinecrypto/chtaexplorer:latest
  docker tag shorelinecrypto/chtaexplorer:latest chtaexplorer:latest
```

Alternatively at first step, you can build chtaexplorer:latest image with below command:

```
  cd ~/chtaexplorer
  docker-compose up -d
  
```

The above will run container when the docker image exist locally. 

to build manually:

```
  docker build -t chtaexplorer .
```

to stop container:
```
docker-compose down
```

#### config/run mongodb/chtaexplorer

The mongodb is built in the docker image, you can perform below to configure a working explore and mongodb user account.

```
  docker exec -it chtaexplorer /bin/bash
```

Above should allow you to login inside a running container, under path "/root/eiquidus" on root user, run below:
```
  mongosh
  use explorerdb2
  db.createUser( { user: "eiquidus", pwd: "Nd^p2d77ceBX!L", roles: [ "readWrite" ] } )
  exit
```

The above completed mongodb database user account setup. Run below to start explorer web:

```
   cp cheetahcoin.conf ~/.cheetahcoin/
   ~/cheetahcoin_2.4.0_x86_64_linux-gnu/cheetahcoind
   nohup bash loop_sync.sh &
   npm start
```

Now your chtaexplorer should be running at your "http://YourHostnameorIP:3002" web URL.
The initial sync will take about overnight time for full Cheetahcoin blockchain update from beginning. 

