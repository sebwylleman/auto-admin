#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' new_username

# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' comment

# Get the password.
read -p 'Enter the password to use for the account: ' new_password

# Create the account.
useradd -c "${comment}" -m "${new_username}"

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password.
echo "${new_password}" | passwd --stdin "${new_username}"

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# Force password change on first login.
passwd -e "${new_username}"

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${new_username}"
echo
echo 'password:'
echo "${new_password}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0

