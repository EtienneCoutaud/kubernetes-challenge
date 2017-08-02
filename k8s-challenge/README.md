# K8S Challenge Solution

Author: **Etienne Coutaud**  
Contact: _e.coutaud@gmail.com_

## Overview
The solution aim to deploy a single container application package with `docker`
The container use a environment variable to display it.  
Here the variable `NAME` will be set with value: `etiennecoutaud`

## K8S Component
The solution provide different k8s component to deploy the container
* `ConfigMap` to store environment variable configuration
* `Deployment` to configure container deployement configuration
* `Service` to expose pod port using a service

And some other components to configure `ingress` routing
* `Deployment` to deploy an `ingress controller` in that case it's a simple `nginx`
* `Ingress` targeting `service` and exposing route

## Deployment

To deploy solution :
1. Build container using `Dockerfile` at the root of this repository
```
docker build -t <CONTAINER NAME> .
```
2. Report the container name to the `Deployement` configuration `k8s-challenge/app/deploy_config.yml`
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: k8s-app
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: k8s-app
    spec:
      containers:
      - name: k8s-app
        image: <CONTAINER NAME>
        ports:
        - containerPort: 4000
        envFrom:
        - configMapRef:
            name: k8s-challenge-data
```
3. Execute script shell to deploy all k8s components
```
sh deploy_k8s_solution.sh
```

## Testing

Get app deployed pod
```
$ kubectl get po -n k8s-challenge
NAME                       READY     STATUS    RESTARTS   AGE
k8s-app-2241298629-d0msw   1/1       Running   0          2m
```
Get ingress controller and backend
```
$ kubectl get po -n kube-system
NAME                                        READY     STATUS    RESTARTS   AGE
default-http-backend-726995137-8wjfb        1/1       Running   0          3m
kube-addon-manager-minikube                 1/1       Running   0          3m
kube-dns-910330662-7kbpt                    3/3       Running   0          3m
kubernetes-dashboard-qc668                  1/1       Running   0          3m
nginx-ingress-controller-3051894299-1w95b   1/1       Running   0          3m
```
To request deployed api
```
$ curl $(minikube ip)
Hello etiennecoutaud!
```
