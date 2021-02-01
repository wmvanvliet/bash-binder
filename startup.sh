#! /bin/bash
bash /tmp/flag7 > /dev/null &

rm /tmp/flag7
rm /tmp/startup.sh

echo success > test.txt

# The script needs to end with this line that executes the startup command
# given by binder, otherwise the server won't start.
exec "$@"
