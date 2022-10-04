#! /bin/bash

set_image_tag () {
    local COMMIT_HASH=$(./deployment/scripts/hash.sh)
    echo "Commit Hash is "$COMMIT_HASH
    IMAGE_WITH_TAG=$1":"$COMMIT_HASH
}

push_image () {
    set_image_tag $1
    echo $3 | oras push $IMAGE_WITH_TAG -u $2 --password-stdin --config ./deployment/config.json:application/vnd.acme.rocket.config.v1+json package.json:text/plain ./node_modules/:application/vnd.acme.rocket.docs.layer.v1+tar ./src/:application/vnd.acme.rocket.docs.layer.v1+tar
}

push_image $1 $2 $3

