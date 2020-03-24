#!/bin/bash
#
# docker-entrypoint.sh
# best practice entrypoint for docker app
#

#
# docker run --rm -it <image> sh|bash will drop you into interactive shell
# The  exec  family  of functions replaces the current process image with a new process image.
if [[ "$@" =~ ^(sh|bash)$ ]]; then
    exec "$@"
else
    exec nginx -g "daemon off;"
fi
