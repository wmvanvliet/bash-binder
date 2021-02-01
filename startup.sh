#! /bin/bash
echo hello > test.txt
exec "$@"
