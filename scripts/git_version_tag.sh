#!/bin/bash
LAST_VERSION="$(git describe --tags --abbrev=0 | sed -e 's/^v//' -e 's/^package-v//' || echo EOF)"

# Try to reach CHANGELOG.rst
if [ -f CHANGELOG.rst ]; then
	cat CHANGELOG.rst 2>/dev/null | awk "/^${LAST_VERSION} / { exit } { print \$0 }"
	exit 0
fi

#  Changelog which follows https://keepachangelog.com/en/1.0.0/
if [ -f CHANGELOG.md ]; then
	cat CHANGELOG.md 2>/dev/null | awk "BEGIN { ready=0 } /^## \[${LAST_VERSION}\] / { exit } /^## / { ready=1 } { if (ready == 1) { print \$0 } }"
	exit 0
fi

exit 1
