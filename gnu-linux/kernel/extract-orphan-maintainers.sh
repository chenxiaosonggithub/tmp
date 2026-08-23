#!/bin/sh
# SPDX-License-Identifier: GPL-2.0

set -e

usage()
{
	echo "Usage: $0 [MAINTAINERS]" >&2
}

case $# in
0)
	maintainers=$(pwd)/MAINTAINERS
	;;
1)
	maintainers=$1
	;;
*)
	usage
	exit 2
	;;
esac

if [ ! -r "$maintainers" ]; then
	echo "$0: cannot read $maintainers" >&2
	exit 1
fi

# MAINTAINERS entries are separated by blank lines.  Print an entire entry
# when its status line marks it as orphaned.
awk '
BEGIN {
	RS = ""
	FS = "\n"
	ORS = "\n\n"
}

{
	for (i = 1; i <= NF; i++) {
		if ($i ~ /^S:[[:space:]]*Orphan[[:space:]]*$/) {
			print
			next
		}
	}
}
' "$maintainers"
