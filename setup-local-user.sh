#!/bin/bash

# This script creates a new user account on a CentOS system. 
# It will prompt you for a username, a comment for the account (full name), 
# and an initial password. 

# Ensure the script is running with root privileges
if [[ "$UID" -ne 0 ]]
then
  echo "This script requires root privileges. Please run it with sudo."
  exit 1
fi

# Prompt the user to enter a desired username
read -p "Enter a username for the new account: " USERNAME

# Prompt the user to enter a full name or comment for the account
read -p "Enter a full name or comment for the new account: " COMMENT

# Prompt the user to enter a strong password for the new account
read -p "Enter a strong password for the new account: " PASSWORD

# Create the new user account using useradd with the provided username and comment
useradd -c "$COMMENT" -m "$USERNAME"

# Check if the user account creation was successful (exit if not)
if [[ "$?" -ne 0 ]]
then
  echo "An error occurred while creating the user account: $USERNAME"
  exit 1
fi

# Inform the user that the account has been created successfully
echo "The user account '$USERNAME' has been created successfully."

# Set the password for the new user account using passwd with piped input
echo "$PASSWORD" | passwd --stdin "$USERNAME"

# Check if setting the password was successful (exit if not)
if [[ "$?" -ne 0 ]]
then
  echo "An error occurred while setting the password for: $USERNAME"
  exit 1
fi

# Enforce a password change on first login for the new user (recommended security practice)
passwd -e "$USERNAME"

# Inform the user about the newly created account details (excluding password for security)
echo "Username: $USERNAME"
echo "Host: $HOSTNAME"

# Script execution successful, exit with code 0
exit 0
