#!/bin/bash

# This script automates the creation of a new user account on the local system.

# Required argument:
#  * username (login name): You must provide the username you want to create as the first argument when running this script.

# Optional argument:
#  * comment (full name): You can optionally provide the user's full name as the second argument. If not provided, a default comment might be used (depending on your system configuration).

# Script behaviour:
#  * A secure password will be automatically generated for the new account. 
#  * After creation, the script will display a summary containing the username, the generated password (for initial reference only, store passwords securely), and the hostname where the account was created.

# Enforces execution only from the superuser or root user, redirecting any error messages to STDERR.
if [[ "$UID" -ne 0 ]]
then
        echo "Usage: must have superuser or root privileges to execute script." >&2
        exit 1
fi

# Reminds the user to provide an account name as an argument to this script.
if [[ "$#" -lt 1 ]]
then
        echo "Usage: sudo $0 USERNAME [USERNAME]..." >&2
        exit 1
fi

# Uses the first argument provided on the command line as the username for the account.
USERNAME=$1

# Any remaining arguments on the command line will be treated as the comment for the account.
shift
COMMENT=$@

# Generate random a special character out of the string below:
SPECIAL_CHAR=$(echo "!@$%^&*=_-()+?/><" | fold -w1 | shuf | head -c1)

# Automatically generates a strong password for the new account.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c21)$SPECIAL_CHAR

# Creates the user account, redirecting any STDERR to /dev/null if command has an error status, rather than outputing the output on STDOUT.

useradd -c "$COMMENT" -m "$USERNAME" &> /dev/null
if [[ "$?" -ne 0 ]]
then
        echo "Account could not be created." >&2
        exit 1
fi

# Sets the user's password. Send the output to /dev/null (user doesn't need to see this).
echo $PASSWORD | passwd --stdin $USERNAME &> /dev/null

# Verifies successful password creation for the new user.
if [[ "$?" -ne 0 ]]
then
        echo "Unsuccesful password creation for $USERNAME." >&2
        exit 1
fi

# Forces password change at first login. Send the output to /dev/null so that the user doesn't see this.
passwd -e $USERNAME &> /dev/null

# Displays the username, password, and host where the user was created.
echo "username: $USERNAME"
echo "password: $PASSWORD"
echo "host: $HOSTNAME"

# End of script, exit succesfully.
exit 0
