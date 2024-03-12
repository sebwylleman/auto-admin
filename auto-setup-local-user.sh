#!/bin/bash

# This script automates the creation of a new user account on the local system.

# Required argument:
#  * username (login name): You must provide the username you want to create as the first argument when running this script.

# Optional argument:
#  * comment (full name): You can optionally provide the user's full name as the second argument. If not provided, a default comment might be used (depending on your system configuration).

# Script behaviour:
#  * A secure password will be automatically generated for the new account. 
#  * After creation, the script will display a summary containing the username, the generated password (for initial reference only, store passwords securely), and the hostname where the account was created.

# Enforces execution only from the superuser or root user
if [[ "$UID" -ne 0 ]]
then
        echo "Usage: must have superuser or root provileges to execute script."
        exit 1
fi

# Reminds the user to provide an account name as an argument to this script
if [[ "$#" -lt 1 ]]
then
        echo "Usage: sudo $0 USERNAME [USERNAME]..."
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

# Creates the user account, flag if unsuccesful

useradd -c "$COMMENT" -m "$USERNAME"
if [[ "$?" -ne 0 ]]
then
        echo "Account could not be created."
        exit 1
fi

# Sets the user's password.
echo $PASSWORD | passwd --stdin $USERNAME

# Verifies successful password creation for the new user.
if [[ "$?" -ne 0 ]]
then
        echo "Unsuccesful password creation for $USERNAME."
        exit 1
fi

# Enforces password change at first login.
passwd -e $USERNAME

# Displays user information (username, password, host).
echo "username: $USERNAME"
echo "password: $PASSWORD"
echo "host: $HOSTNAME"
exit 0
if [[ "$UID" -ne 0 ]]
then
        echo "Usage: must have superuser or root provileges to execute script."
        exit 1
fi

# Reminds the user to provide an account name as an argument to this script
if [[ "$#" -lt 1 ]]
then
        echo "Usage: sudo $0 USERNAME [COMMENT]..."
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

# Creates the user account, flaggs if unsuccesful

useradd -c $COMMENT -m $USERNAME
if [[ "$?" -ne 0 ]]
then
        echo "Account could not be created."
        exit 1
fi

# Sets the user's password.
echo $PASSWORD | passwd --stdin $USERNAME

# Verifies successful password creation for the new user.
if [[ "$?" -ne 0 ]]
then
        echo "Unsuccesful password creation for $USERNAME."
        exit 1
fi

# Enforces password change at first login.
passwd -e $USERNAME

# Display the username, password, and host where the user was created.
echo "username: $USERNAME"
echo "password: $PASSWORD"
echo "host: $HOSTNAME"

# End of script, exit succesfully
exit 0