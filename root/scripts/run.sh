#!/bin/sh
set -e

# Httpd entrypoint (pid 1), run as root
[ "$1" = "httpd" ] || exec "$@" || exit $?

# execute any pre-init scripts, useful for images
# based on this image
for i in /scripts/pre-init.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-init.d - processing $i"
		. "${i}"
	fi
done

# set apache as owner/group
chown -R apache:apache /app

# execute any pre-exec scripts, useful for images
# based on this image
for i in /scripts/pre-exec.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-exec.d - processing $i"
		. "${i}"
	fi
done

# Drop root privilege (no way back), exec provided command as user apache
cmd=exec; for i; do cmd="$cmd '$i'"; done
exec su -s /bin/sh -c "$cmd" apache
