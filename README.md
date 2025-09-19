# How to deploy EMQX 5.8.6

## Environment

* Rocky Linux 9.6 x86_64
* Docker Compose version v2.38.2
* K3s Version: v1.33.4+k3s1
* ansible [core 2.14.18]

## 1. Deploy EMQX Standalone

### 1.1 use docker compose to deploy in local machine

```
cd docker-compose/
docker compose up -d      # Start EMQX
docker compose down       # Stop EMQX
docker compose down -v    # Stop EMQX and delete volume
```

### 1.2 use ansible to deploy in remote machine

Install ansible
```
dnf install -y epel-release && yum install -y ansible sshpass
```

Use ansible to deploy in remote machine

```
cd ansible/
./deploy.sh -H [your_remote_machine_ip] -e int install    # Install EMQX
./deploy.sh -H [your_remote_machine_ip] uninstall         # Uninstall EMQX
```

## 2. Deploy EMQX Cluster

### 2.1 use k3s/k8s to deploy EQMX 3-nodes cluster

```
kubectl create ns emqx
kubectl apply -f emqx-3nodes-cluster.yaml     # Start or Update EMQX cluster
kubectl delete -f emqx-3nodes-cluster.yaml    # Stop EMQX cluster
kubectl delete ns emqx                        # Delete EMQX cluster
```
