#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: find_pod_by_ip.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description : sudo ./find_pod_by_ip.sh 172.17.0.2
##               TODO: change this line to shorter
## --
## Created : <2018-01-04>
## Updated: Time-stamp: <2018-01-04 23:47:25>
##-------------------------------------------------------------------
set -e

# List all pods in all namespaces
## kubectl get --all-namespaces pod

# List all pods with columns: pod name, pod ip, node ip and namespace name
## kubectl get --all-namespaces pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.hostIP}{"\t"}{.status.podIP}{"\t"}{.metadata.namespace}{"\n"}{end}'

# Get pod json format
## kubectl get pods -o json

if [ -z "$pod_ip" ]; then
    echo "pod_ip should be set."
    exit 1
fi

# Find pods by pod ip
kubectl get --all-namespaces pods \
        -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.hostIP}{"\t"}{.status.podIP}{"\t"}{.metadata.namespace}{"\n"}{end}' \
    | grep "$pod_ip"

# How to run the script:
# echo pod_ip="172.42.42.1"; curl -L https://raw.githubusercontent.com/DennyZhang/kubernetes-scripts/master/find_pod_by_ip.sh | bash

## ,----------- Example
## | root@k8s1:~# kubectl get --all-namespaces pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.hostIP}{"\t"}{.status.podIP}{"\t"}{.metadata.namespace}{"\n"}{end}' | grep "$pod_ip"
## | wait-8mjxl      172.42.42.2     172.17.0.2      default
## | kubernetes-dashboard-6ddcb6df4c-wqtxn   172.42.42.3     172.17.0.2      kube-system
## | nginx-deployment-6546d89874-kllt9       172.42.42.2     172.17.0.2      nginx-6node-test
## `-----------
## File: find_pod_by_ip.sh ends
