#!/bin/sh

E_MISSING_APP=17

# This snippet is self-contained. If your script already provides logging and
# termination helpers, replace these two functions with its own versions.
_error() {
	printf '%s\n' "$*" >&2
}

_fatal() {
	exit_code=$1
	shift
	_error "$*"
	exit "$exit_code"
}

_require() {
	missing_bin=0

	for bin in "$@"; do
		# `command -v` is specified by POSIX and is usually a shell builtin.
		# For legacy environments, `which "$bin" > /dev/null 2>&1` is an
		# alternative, but it is less portable and can be an external command.
		if ! command -v "$bin" > /dev/null 2>&1; then
			missing_bin=1
			_error "Required: $bin"
		fi
	done

	if [ "$missing_bin" -ne 0 ]; then
		_fatal "$E_MISSING_APP" "One or more executables or apps are missing."
	fi
}
