# How to Setup Explorer for Cheetahcoin (CHTA) 

This guide explains step by step at high level to self host an explorer for Cheetahcoin (CHTA) in a linux server such as Ubuntu 18.04.

Explorer requires a full node of CHTA with "-txindex" flag.  You could use the same full node that you run Cheetah_Cpuminer on.
The explorer runs with mongodb that also needs about 3G of disk for storing the blockchain content in its database. 

## Example of Working CHTA Explorer

http://chtaexplorer.mooo.com:3002/

## Explorer software

#### iquidus explorer - 1.6.2-legacy

The latest commit of iquidus explorer does not work with CHTA.  Earlier version '1.6.2-legacy' branch was used instead at:
https://github.com/iquidus/explorer/tree/1.6.2-legacy

```
  git clone https://github.com/iquidus/explorer.git chtaexplorer
  cd chtaexplorer
  git checkout 1.6.2-legacy
  git pull 

```

#### Other software and working versions

* mongodb v4.2.13 
* node.js v12.18.4

Follow guide here for installing mongodb in various version of Ubuntu linux:

https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

For nodejs, we recommend using nvm method for installation. 

## Error Handling on Nodejs installation for iquidus explorer

There might be a lot of failures and security warning after issuing "npm install --production" in Ubuntu 18.04. 

Follow the warning guide and do several round of below command for fixing the errors:
```
npm audit fix
npm install
npm audit fix
```

After back and forth fix as shown above, your explorer folder should be ready for production. 

## Copy the CHTA settings/logo and port forward to public

Copy the CHTA logo file and setting file as example here. You can modify and change full node/mongodb user/password, port, etc to tailor to your needs. 

You can setup a port forward in your home router for 3002 port to be visable to public. There are also free DNS or Dynamic DNS providers 
that allow a domain URL to point to your home IPs for this purpose.

## Issues in syncing/operating explorer

(1) Common error:  "Script already running.."
simply remove the tmp/index.pid file and you will be able to run the script.

When explorer or wallet shut down abnormally, this error will come 
and explorer won't refresh to latest blocks.

(2) Common error: "Cannot read property 'length' of undefined" error from scripts/sync.js"

Follow this issue to fix the mongodb/explorer database:
https://github.com/iquidus/explorer/issues/29

```
newmight2015 commented on Jan 19, 2016
node scripts/sync.js index reindex then node scripts/sync.js index update

@iquidus
 
Owner
iquidus commented on Jan 23, 2016
also check you have txindex=1 set in your coins .config or are launching the coin daemon with the -txindex flag.
```
 
