#!/bin/bash

# This script creates a new user then adds the user to the same Linux system as the script is executed on.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges
if [[ "$UID" -ne 0 ]]
then
  echo "Run script as sudo or root."
  exit 1
fi

# Prompts user to enter username, and saves it into a variable
read -p "Enter a username: " USERNAME

# Prompts user to enter a name for this new account
read -p "Enter a name: " COMMENT

# Prompts user to enter an initial password for this new account
read -p "Enter an initial password: " PASSWORD

# Create the new user account
useradd -c "$COMMENT" -m "$USERNAME"

# Check if the user account was created
if [[ "$?" -ne 0 ]]
then
  echo "No existing account for: $USERNAME user."
  exit 1
else
  echo "User account: $USERNAME was succesfully created."
fi

# Link the password to the created user
echo $PASSWORD | passwd --stdin $USERNAME

# Flag if passwd command was unsuccesful
if [[ "$?" -ne 0 ]]
then
        echo "Unsuccesful password set."
        exit 1
fi

# Force password change (good practice)
passwd -e $USERNAME

# Display the username, password, and host where the user was created.
echo "username: $USERNAME"
echo "password: $PASSWORD"
echo "host: $HOSTNAME"

# End of script, exit succesfully
exit 0
