#!/bin/sh

eval $(minikube docker-env)

# Container app components
kubectl create ns k8s-challenge
kubectl create -f app/config_map.yml -n k8s-challenge
kubectl create -f app/deploy_config.yml -n k8s-challenge
kubectl create -f app/service.yml -n k8s-challenge

# Ingress components
kubectl create -f ingress/default_backend.yml -n kube-system
kubectl create -f ingress/nginx_ingress_controller.yml -n kube-system
kubectl create -f ingress/ingress.yml -n k8s-challenge
