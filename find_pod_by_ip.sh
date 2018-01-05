#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: find_pod_by_ip.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description : sudo ./find_pod_by_ip.sh 172.17.0.2
## --
## Created : <2018-01-04>
## Updated: Time-stamp: <2018-01-04 23:08:31>
##-------------------------------------------------------------------
set -e

# List all pods in all namespaces
## ,----------- Example
## | kubectl get --all-namespaces pod
## | root@k8s3:~# kubectl get --all-namespaces pod
## | NAMESPACE          NAME                                    READY     STATUS    RESTARTS   AGE
## | kube-system        etcd-k8s1                               1/1       Running   0          19h
## | kube-system        kube-apiserver-k8s1                     1/1       Running   0          19h
## | kube-system        kube-controller-manager-k8s1            1/1       Running   0          19h
## | kube-system        kube-dns-6f4fd4bdf-5jhmb                3/3       Running   0          19h
## | kube-system        kube-proxy-cjj2t                        1/1       Running   0          19h
## | kube-system        kube-proxy-r747f                        1/1       Running   0          19h
## | kube-system        kube-proxy-vtxfx                        1/1       Running   0          19h
## | kube-system        kube-scheduler-k8s1                     1/1       Running   0          19h
## | kube-system        kubernetes-dashboard-6ddcb6df4c-wqtxn   1/1       Running   0          3h
## | kube-system        weave-net-4b7wq                         2/2       Running   0          19h
## | kube-system        weave-net-bf72z                         2/2       Running   29         19h
## | kube-system        weave-net-fdbjn                         2/2       Running   30         19h
## | nginx-6node-test   nginx-deployment-6546d89874-68wnq       1/1       Running   0          5m
## | nginx-6node-test   nginx-deployment-6546d89874-7b727       1/1       Running   0          5m
## | nginx-6node-test   nginx-deployment-6546d89874-crhrm       1/1       Running   0          5m
## | nginx-6node-test   nginx-deployment-6546d89874-kllt9       1/1       Running   0          5m
## | nginx-6node-test   nginx-deployment-6546d89874-p2zv2       1/1       Running   0          5m
## | nginx-6node-test   nginx-deployment-6546d89874-rv2q2       1/1       Running   0          5m
## `-----------

# List all pods with columns: pod name, pod ip, node ip and namespace name
## ,----------- Example
## | root@k8s1:~# kubectl get --all-namespaces pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.hostIP}{"\t"}{.status.podIP}{"\t"}{.metadata.namespace}{"\n"}{end}'
## | wait-8mjxl      172.42.42.2     172.17.0.2      default
## | etcd-k8s1       172.42.42.1     172.42.42.1     kube-system
## | kube-apiserver-k8s1     172.42.42.1     172.42.42.1     kube-system
## | kube-controller-manager-k8s1    172.42.42.1     172.42.42.1     kube-system
## | kube-dns-6f4fd4bdf-5jhmb        172.42.42.1     10.32.0.2       kube-system
## | kube-proxy-cjj2t        172.42.42.1     172.42.42.1     kube-system
## | kube-proxy-r747f        172.42.42.3     172.42.42.3     kube-system
## | kube-proxy-vtxfx        172.42.42.2     172.42.42.2     kube-system
## | kube-scheduler-k8s1     172.42.42.1     172.42.42.1     kube-system
## | kubernetes-dashboard-6ddcb6df4c-wqtxn   172.42.42.3     172.17.0.2      kube-system
## | weave-net-4b7wq 172.42.42.1     172.42.42.1     kube-system
## | weave-net-bf72z 172.42.42.2     172.42.42.2     kube-system
## | weave-net-fdbjn 172.42.42.3     172.42.42.3     kube-system
## | nginx-deployment-6546d89874-68wnq       172.42.42.2     172.17.0.3      nginx-6node-test
## | nginx-deployment-6546d89874-7b727       172.42.42.2     172.17.0.4      nginx-6node-test
## | nginx-deployment-6546d89874-crhrm       172.42.42.3     172.17.0.5      nginx-6node-test
## | nginx-deployment-6546d89874-kllt9       172.42.42.2     172.17.0.2      nginx-6node-test
## | nginx-deployment-6546d89874-p2zv2       172.42.42.3     172.17.0.3      nginx-6node-test
## | nginx-deployment-6546d89874-rv2q2       172.42.42.3     172.17.0.4      nginx-6node-test
## `-----------

pod_ip=${1?}
# Find pod by ip
# TODO: change this line to shorter
kubectl get --all-namespaces pods \
        -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.hostIP}{"\t"}{.status.podIP}{"\t"}{.metadata.namespace}{"\n"}{end}' \
    | grep "$pod_ip"
## File: find_pod_by_ip.sh ends
