#!/usr/bin/env bash

bold=$(tput bold)
normal=$(tput sgr0)

IS_DOCKER_DESKTOP=$(kubectl get nodes | grep "docker-desktop"| wc -l)

if [[ "$IS_DOCKER_DESKTOP" -eq "1" ]]
then
    kubectl apply -f docker-desktop/docker-standard-storage-class.yaml
#    kubectl apply -f docker-desktop/knife.yaml
else
    echo "not on docker desktop, standard storage class exists, skipping."
fi

docker image tag hugo-page-tikautz ghcr.io/g-tikautz/hugo-page-tikautz:latest
docker push ghcr.io/g-tikautz/hugo-page-tikautz:latest
docker image tag hugo-backend-tikautz ghcr.io/g-tikautz/hugo-backend-tikautz:latest
docker push ghcr.io/g-tikautz/hugo-backend-tikautz:latest
kubectl delete -f appsrv.yaml
kubectl delete -f nginx.yaml
kubectl apply -f namespace.yaml
kubectl apply -f appsrv.yaml
kubectl apply -f nginx.yaml

echo "----------"
echo "DO NOT FORGET: make the ${bold}docker image public${normal} on ghcr.io"
echo "----------"
