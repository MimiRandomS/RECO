#!/bin/sh

if [ "$#" -ne 9 ]; then
    echo "Usage: $0 <username> <group> <full_name> <home_directory> <shell> <dir_perm> <group_perm> <other_perm>"
    exit 1
fi

USERNAME=$1
GROUP=$2
FULLNAME=$3
HOME_DIR=$4
SHELL=$5
PERM_DIR=$6
PERM_GROUP=$7
PERM_OTHER=$8

if ! grep -q "^$GROUP:" /etc/group; then
    echo "Group $GROUP does not exist. Creating..."
    groupadd "$GROUP"
fi

useradd -m -d "$HOME_DIR" -s "$SHELL" -c "$FULLNAME" -g "$GROUP" "$USERNAME"
chmod "$PERM_DIR" "$HOME_DIR"
chmod "$PERM_GROUP" "$HOME_DIR"
chmod "$PERM_OTHER" "$HOME_DIR"

echo "User $USERNAME created successfully with group $GROUP and permissions set."
