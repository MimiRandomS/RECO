#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <group_name> <group_id>"
    exit 1
fi

GROUP_NAME=$1
GROUP_ID=$2

if grep -q "^$GROUP_NAME:" /etc/group; then
    echo "Group $GROUP_NAME already exists."
    exit 1
fi

groupadd -g "$GROUP_ID" "$GROUP_NAME"
echo "Group $GROUP_NAME created with GID $GROUP_ID."
