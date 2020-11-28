FROM arm32v7/debian:latest
MAINTAINER Raul Plaza (ZilverNet) <rplaza@gmail.com>

RUN echo "deb http://apt.ntop.org/buster_pi armhf/" > /etc/apt/sources.list.d/ntop.list
RUN echo "deb http://apt.ntop.org/buster_pi all/" >> /etc/apt/sources.list.d/ntop.list

RUN apt-get clean all
RUN apt-get update
RUN apt-get -y --allow-unauthenticated install nprobe ntopng

EXPOSE 3000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /tmp/run.sh
RUN chmod +x /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]
