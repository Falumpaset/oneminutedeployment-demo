#! /bin/bash
echo $REGISTRY_PASSWORD | oras pull -u $REGISTRY_USER --password-stdin $IMAGE
$@
