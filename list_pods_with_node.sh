#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: list_pods_with_node.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2018-01-04>
## Updated: Time-stamp: <2018-01-04 23:32:21>
##-------------------------------------------------------------------
set -e

# Columns: pod name, node name, namespace
kubectl get --all-namespaces pods \
        -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.nodeName}{"\t"}{.metadata.namespace}{"\t"}{"\n"}{end}'

## ,----------- Sample
## | root@k8s1:~# kubectl get --all-namespaces pods \
## | >         -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.nodeName}{"\t"}{.metadata.namespace}{"\t"}{"\n"}{end}'
## | etcd-k8s1	k8s1	kube-system
## | kube-apiserver-k8s1	k8s1	kube-system
## | kube-controller-manager-k8s1	k8s1	kube-system
## | kube-dns-6f4fd4bdf-5pfhf		kube-system
## | kube-proxy-6vb8t	k8s1	kube-system
## | kube-scheduler-k8s1	k8s1	kube-system
## `-----------
## File: list_pods_with_node.sh ends
