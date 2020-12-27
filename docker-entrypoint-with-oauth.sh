#!/bin/sh
# vim:sw=4:ts=4:et

set -e

NL=$'\n'

graceful_exit() {
	echo "Exiting docker-entrypoint-with-oauth.sh gracefuly due to signal $1"
	kill $1 $NGINX_PID || wait $NGINX_PID
	echo "Nginx exited, now signalling oauth2proxy pids."
	kill -TERM $OAUTH2PROXY_PIDS || wait $OAUTH2PROXY_PIDS
	echo "oauth2proxy pids exited."
	exit 0
}

trap 'graceful_exit INT' -INT
trap 'graceful_exit TERM' -TERM
trap 'graceful_exit QUIT' -QUIT

/docker-entrypoint-original.sh "$@" &
NGINX_PID=$!

if [ -n "$OAUTH2PROXY_VARS" ]; then
	echo "$OAUTH2PROXY_VARS" | while read -r line; do
		echo "Starting oauth2proxy with ${line}"
		/oauth2proxy $line &
		OAUTH2PROXY_PIDS="${OAUTH2PROXY_PIDS}${NL}$!"
	done
fi

wait NGINX_PID
echo "Exiting docker-entrypoint-with-oauth.sh non-gracefuly."
