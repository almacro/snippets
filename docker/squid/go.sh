DOCKER_NET=build-net

SQUID_CACHE_DIR=$PWD/data/squid
SQUID_LOG_DIR=$PWD/data/log
SQUID_CONF_DIR=$PWD/etc/squid

#       --rm \
docker run \
       --name squid \
       -d \
       --publish 3128:3128 \
       --network $DOCKER_NET \
       --volume $SQUID_CONF_DIR/squid.conf:/etc/squid/squid.conf \
       --volume $SQUID_CACHE_DIR:/var/spool/squid \
       --volume $SQUID_LOG_DIR:/var/log/squid \
       sameersbn/squid
