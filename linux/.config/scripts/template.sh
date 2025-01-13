#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: <online-judge>"
	exit 1
fi

declare -A judge_map

judge_map["cf"]="codeforces"
judge_map["at"]="atcoder"

judge=${judge_map[$1]}

if [ -z "$judge" ]; then
    echo "Unknown judge: $1"
    exit 1
fi

TEMPLATE_PATH="${HOME}/Templates/competitive-programming/${judge}/"

if [ ! -d "$TEMPLATE_PATH" ]; then
    echo "Directory does not exist: $TEMPLATE_PATH"
    exit 1
fi

cp -r "${TEMPLATE_PATH}"* .

