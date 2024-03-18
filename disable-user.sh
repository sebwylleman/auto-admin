#!/bin/bash

# This script allows management of user accounts on the local system.
# It offers options for disabling, deleting, and potentially archiving users.

# Enforces script to be run only by the superuser or root account.
if [[ "$UID" -ne 0 ]]
then
        echo 'Usage: Required sudo or root privileges to run script' >&2
        exit 1
fi

# Display the usage then exit.
usage() {
                echo "Usage: $0 [-dra] USER [USER2]..." >&2
                echo "Delete a local user account and related files." >&2
                echo "-d Deletes accounts." >&2
                echo "-r Removes the account's home directory." >&2
                echo "-a Creates an archive of the account's home directory." >&
2
                exit 1
}

# Parse the command options.
while getops dra OPTION
do
        case $OPTION in
                d) DELETE_USER='true' ;;
                r) REMOVE_OPTION='-r' ;;
                a) ARCHIVE='true' ;;
                ?) usage ;;
        esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# Help the user if at least one argument hasn't been provided.
if [[ "$#" -lt 1 ]]
then
        echo 'No valid USER account(s) provided as argument to command. ' >&2
        usage
fi