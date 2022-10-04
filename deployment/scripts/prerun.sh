#! /bin/bash

check_variable () { 
    if [[ "" = "$2" ]]
    then
    echo $1 "is unset please set it"
    exit 255
    fi
}

check_all_varibales () {
    ID_KUBE="KUBECONFIG"
    ID_REGISTRY="REGISTRY"
    ID_REGISTRY_USERNAME="REGISTRY_USERNAME"
    ID_REGISTRY_PASSWORD="REGISTRY_PASSWORD"

    check_variable $ID_REGISTRY $1
    check_variable $ID_REGISTRY_USERNAME $2
    check_variable $ID_REGISTRY_PASSWORD $3
    check_variable $ID_KUBE $KUBECONFIG
}
check_all_varibales $1 $2 $3