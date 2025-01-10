# How to Setup Explorer for Cheetahcoin (CHTA) 

This guide explains step by step at high level to self host an explorer for Cheetahcoin (CHTA) in a linux server such as Ubuntu 18.04.

Explorer requires a full node of CHTA with "-txindex" flag.  You could use the same full node that you run Cheetah_Cpuminer on.
The explorer runs with mongodb that also needs about 3G of disk for storing the blockchain content in its database. 

## Example of Working CHTA Explorer

http://chtaexplorer.mooo.com:3002/

## Explorer software

#### iquidus explorer - 1.7.4

The latest commit of iquidus explorer version v1.7.4 works well with Cheetahcoin

```
  git clone https://github.com/iquidus/explorer.git chtaexplorer

```

### patch to fix syncing crash/package version

The 1.6.2-legacy version will not work directly, it will crash here and there. To fix the crash, copy file "lib/explorer.js" to replace v1.6.2 default file.

file "package.json" was provided to have correction version at bottom of web page.

#### Other software and working versions

* mongodb v4.2.24
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

If the wallet crashed with "core dumped".  restarted wallet with below, possibly in screen session to monitor error msgs:
```
./cheetahcoind  -txindex -reindex 

```

The patch mainly followed this issue to fix the mongodb/explorer database:
https://github.com/iquidus/explorer/issues/56

After applied the above patch file,  then reindex/check explorer 

```
node scripts/sync.js index reindex
node scripts/sync.js index check
```
The explorer should be able to update block data from here.