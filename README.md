cyanite-docker
================

Cyanite in Docker (https://github.com/pyr/cyanite)

### Running

```
sudo docker build -t gitinsky/cyanite https://github.com/gitinsky/cyanite-docker.git

for ii in logs; do sudo mkdir -vp /storage/cyanite/$ii; done

sudo docker run \
  -e CLUSTER_ADDRS="one of the cluster addresses" \
  -e LOG_LEVEL="info" \
  -p 2003:2003 -p 2080:2080 \
  -v /storage/cyanite/logs:/storage/logs \
  -t -i gitinsky/cyanite \
  ;
```
