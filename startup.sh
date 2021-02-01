#! /bin/bash
echo hello > test.txt
echo hello >> test.txt
exec "$@"
