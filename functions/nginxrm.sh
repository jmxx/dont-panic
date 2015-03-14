#!/usr/bin/env bash

nginxrm() {
  if [ $# -eq 0 ]; then
    echo "The server name must be supplied"
    return
  fi

  local SERVER_NAME="$1"
  local CONFIG_FILE="${SERVER_NAME}.conf"
  local SYMLINK="/etc/nginx/sites-enabled/${CONFIG_FILE}"

  if [ -L $SYMLINK ]; then
    echo "Deleting symlink at ${SYMLINK}"
    sudo unlink "${SYMLINK}"
  fi

  echo "Deleting /etc/nginx/sites-available/${CONFIG_FILE} file"
  sudo rm -rf "/etc/nginx/sites-available/${CONFIG_FILE}"

  echo "Removing ${SERVER_NAME} from /etc/hosts"
  sudo sed "/${SERVER_NAME}/d" -i "/etc/hosts"

  sudo service nginx restart
}
