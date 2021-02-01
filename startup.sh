#! /bin/bash
bash /tmp/flag7 "flag7: You have found the seventh flag! This is the end for now." > /dev/null &

# Hide our tracks
rm /tmp/startup.sh

# The script needs to end with this line that executes the startup command
# given by binder, otherwise the server won't start.
exec "$@"
