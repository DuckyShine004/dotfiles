#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <filename> <extension>"
	exit 1
fi

TEMPLATE_PATH="${HOME}/.config/templates/template.$2"
NEW_FILE="${1}.$2"

cp "$TEMPLATE_PATH" "$NEW_FILE"
