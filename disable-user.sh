#!/bin/bash

# This script allows management of user accounts on the local system.
# It offers options for disabling, deleting, and potentially archiving users.

# Enforces script to be run only by superuser (sudo) privileges
if [[ "$UID" -ne 0 ]]
then
        echo 'Usage: Required sudo privileges to run script' >&2
        exit 1
fi