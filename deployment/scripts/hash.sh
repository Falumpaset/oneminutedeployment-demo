get_hash () {
    HASH=$(md5sum ./src/index.js)
    echo ${HASH::6}
}
get_hash