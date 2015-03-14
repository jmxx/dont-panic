#!/usr/bin/env bash

PANIC_DIR=`dirname $(dirname $0)`

nginxadd() {
  if [ $# -eq 0 ]; then
    echo "At least a server name must be supplied"
    return
  fi

  local SERVER_NAME="$1"
  local CONFIG_FILE="${SERVER_NAME}.conf"
  local ROOT_PATH=`pwd`
  local PORT="${3:-80}"

  if [ ! -z "$2" ]; then
    local ROOT_PATH=`readlink -f "$2"`
  fi

  NGINX_ADD_BLOCK=$(cat "${PANIC_DIR}/templates/php-laravel.conf" | sed -e "s/\${SERVER_NAME}/$SERVER_NAME/" -e "s/\${PORT}/$PORT/" -e "s,\${ROOT_PATH},$ROOT_PATH,")

  echo "Creating /etc/nginx/sites-available/${CONFIG_FILE}"
  sudo -- sh -c "echo '$NGINX_ADD_BLOCK' > /etc/nginx/sites-available/${CONFIG_FILE}"

  echo "Creating symlink at /etc/nginx/sites-enabled/${CONFIG_FILE}"
  sudo ln -fs "/etc/nginx/sites-available/${CONFIG_FILE}" "/etc/nginx/sites-enabled/${CONFIG_FILE}"

  echo "Adding ${SERVER_NAME} to /etc/hosts"
  sudo -- sh -c "echo \"127.0.0.1\t${SERVER_NAME}\" >> /etc/hosts"

  sudo service nginx restart
  sudo service php5-fpm restart
  unset NGINX_ADD_BLOCK
}
