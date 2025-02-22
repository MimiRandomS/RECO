#!/bin/sh

if [ "$#" -ne 8 ]; then
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

# Verificar si el grupo existe, si no, crearlo
if ! grep -q "^$GROUP:" /etc/group; then
    echo "Group $GROUP does not exist. Creating..."
    groupadd "$GROUP"
fi

# Crear usuario con su grupo, directorio y shell
if ! useradd -m -d "$HOME_DIR" -s "$SHELL" -c "$FULLNAME" -g "$GROUP" "$USERNAME"; then
    echo "Error creating user $USERNAME"
    exit 1
fi

# Aplicar permisos correctamente
if ! chmod "$PERM_DIR$PERM_GROUP$PERM_OTHER" "$HOME_DIR"; then
    echo "Error setting permissions for $HOME_DIR"
    exit 1
fi

echo "User $USERNAME created successfully with group $GROUP and permissions set."
