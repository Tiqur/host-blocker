#!/bin/bash

case "$1" in
  start)
    echo "Starting..."
    echo -e "#-HostBlocker-#\ntext\n#-HostBlocker-#" >> /etc/hosts
    ;;
  stop)
    echo "Stopping..."
    sudo sed -i '/#-HostBlocker-#/,/#-HostBlocker-#/d' /etc/hosts
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
esac

exit 0
