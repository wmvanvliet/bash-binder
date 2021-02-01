#! /bin/bash
echo hello > test.txt
echo hello >> test.txt
rm /tmp/startup.sh

# The script needs to end with this line that executes the startup command
# given by binder, otherwise the server won't start.
exec "$@"
