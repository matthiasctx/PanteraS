#!/bin/bash
[ -z ${HOST_IP} ] || exec supervisord
cat << EOF
PanteraS - Platform as a Service
Usage:

$ git clone https://github.com/eBayClassifiedsGroup/PanteraS
$ cd PanteraS

# ------------------------------------------
# Stand Alone (Master & Slave):

$ ./generate_yml.sh
$ docker-compose up -d


# ------------------------------------------
# 3 Masters (without Slaves daemons) mode:
# Repeat on every master docker host, but keep in mind to have ZOOKEEPER_ID uniq:

$ mkdir restricted
$ echo 'ZOOKEEPER_ID=1' >> restricted/host
$ echo 'ZOOKEEPER_HOSTS="master-1:2181,master-2:2181,master-3:2181"' >> restricted/host
$ echo 'CONSUL_HOSTS="-join=master-1 -join=master-2 -join=master-3"' >> restricted/host
$ SLAVE=false ./generate_yml.sh
$ docker-compose up -d

# ------------------------------------------
# Add Slaves (Master need to be set up before)
# Reapeat on each Slave docker host:

$ mkdir restricted
$ echo 'ZOOKEEPER_HOSTS="master-1:2181,master-2:2181,master-3:2181"' >> restricted/host
$ echo 'CONSUL_HOSTS="-join=master-1 -join=master-2 -join=master-3"' >> restricted/host
$ echo 'MASTER=false' >> restricted/host
$ ./generate_yml.sh
$ docker-compose up -d

more info on github
EOF
