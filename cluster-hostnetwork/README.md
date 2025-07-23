# EMQX static Cluster with Docker in host network mode

modify node1 and node2 /etc/hosts
```
192.168.149.31 emqx-node1.cluster.local
192.168.149.32 emqx-node2.cluster.local
```

start emqx docker on node1
```
docker compose up -d
```

start emqx docker on node2
```
docker compose up -d
```
