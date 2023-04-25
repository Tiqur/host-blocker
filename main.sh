#!/bin/bash

case "$1" in
  start)
    # If already running, exit
    if grep -q "#-HostBlocker-#" /etc/hosts; then
      echo "Already running..."
      exit 0
    fi

    # Take user input until user submits empty line
    echo "Enter the hosts you want to block:"
    hosts="\n"
    while true
    do
      read line
      if [ -z "$line" ]; then
        break
      else
        # Append to hosts string and redirect domain name to localhost
        hosts+="127.0.0.0 $line"$'\n'
      fi
    done

    # Append to hosts file
    echo "Starting..."
    printf "#-HostBlocker-#%b#-HostBlocker-#" "$hosts" >> /etc/hosts
    resolvectl flush-caches
    ;;
  stop)
    # Remove from hosts file
    echo "Stopping..."
    sudo sed -i '/#-HostBlocker-#/,/#-HostBlocker-#/d' /etc/hosts
    resolvectl flush-caches
    ;;
  *)
    # Help
    echo "Usage: $0 {start|stop}"
    exit 1
esac

exit 0
