
#PROXY=""
#NO_PROXY=""

# Set Proxy
if [ ! -z ${PROXY} ]; then
    http_proxy=${PROXY}
    https_proxy=${PROXY}
    HTTP_PROXY=${PROXY}
    HTTPS_PROXY=${PROXY}
    ftp_proxy=${PROXY}

    no_proxy="localhost"

    if [ ! -z $NO_PROXY ]; then
        no_proxy="${no_proxy},${NO_PROXY}"
    fi

    export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY ftp_proxy no_proxy
fi
