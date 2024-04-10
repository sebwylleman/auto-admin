#!/bin/bash

# This script allows management of user accounts on a Centos system.
# It offers options for disabling, deleting, and potentially archiving users.

ARCHIVE_DIR='/archive'

# Enforces script to be run only by the superuser, or the root account (not advisable).
if [[ "$UID" -ne 0 ]]; then
    echo 'Usage: Required sudo or root privileges to run script' >&2
    exit 1
fi

# Display the usage then exit.
usage() {
    echo "Usage: $0 [-dra] USER [USER2]..." >&2
    echo "Delete a local user account and related files." >&2
    echo "-d Deletes accounts." >&2
    echo "-r Removes the account's home directory." >&2
    echo "-a Creates an archive of the account's home directory." >&2
    exit 1
}

# Parse the command options.
while getops dra OPTION; do
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
if [[ "$#" -lt 1 ]]; then
    echo 'No valid USER account(s) provided as argument to command. ' >&2
    usage
fi

# Loop through all the usernames supplied as arguments.
for USER in "$@"; do
    echo "Processing user: $USERNAME"

    # Make sure the UID of the account is at least 1000 so that we do not remove any system accounts.
    USERID=$(id -u "${USER}")
    if [[ "${USERID}" -lt 1000 ]]; then
        echo "Refusing to remove the $USER account with UID ${USERID}." >&2
        exit 1
    fi

    # Creates an archive if requested to do so.
    if [[ "${ARCHIVE}" = 'true' ]]; then

        # Make sure the ARCHIVE_DIR directory exists.
        if [[ ! -d "${ARCHIVE_DIR}" ]]; then
            echo "Creating ${ARCHIVE_DIR} directory."
            mkdir -p "${ARCHIVE_DIR}"
            if [[ "${?}" -ne 0 ]]; then
                echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
                exit 1
            fi
        fi

        # Archives the user's home directory and move it into the ARCHIVE_DIR.
        HOME_DIR="/home/${USER}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USER}.tgz"
        if [[ -d "${HOME_DIR}" ]]; then
            echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
            tar -zcf "${ARCHIVE_FILE}" "${HOME_DIR}" &> /dev/null
            if [[ "${?}" -ne 0 ]]; then
                echo "Could not create ${ARCHIVE_FILE}." >&2
                exit 1
            fi
        else
            echo "${HOME_DIR} does not exist or is not a directory." >&2
            exit 1
        fi
    fi

    if [[ "${DELETE_USER}" = 'true' ]]; then
        # Deletes the user
        userdel ${REMOVE_OPTION} ${USER}
        # Check to see if the userdel command succeeded.
        # We don't want to tell the user that an account was deleted when it hasn't been.
        if [[ "${?}" -ne 0 ]]; then
            echo "The account ${USERNAME} was NOT deleted." >&2
            exit 1
        fi
        echo "The account ${USERNAME} was deleted."
    else
        chage -E 0 ${USERNAME}
        # Check to see if the chage command succeeded.
        # We don't want to tell the user that an account was disabled when it hasn't been.
        if [[ "${?}" -ne 0 ]]; then
            echo "The account ${USERNAME} was NOT disabled." >&2
            exit 1
        fi
        echo "The account ${USERNAME} was disabled."
    fi 
    # END of if "${DELETE_USER}" = 'true'
done

exit 0
