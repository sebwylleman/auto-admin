#!/bin/bash

#Goal:
# The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on.

# Scenario:
# Imagine that you're working as a Linux System Administrator for a fast growing company. The latest company initiative requires you to build and deploy dozens of servers. You're falling behind schedule and are going to miss your deadline for these new server deployments because you are constantly being interrupted by the help desk calling you to create new Linux accounts for all the people in the company who have been recruited to test out the company's newest Linux-based application.
# In order to meet your deadline and keep your sanity, you decide to write a shell script that will create new user accounts. Once you're done with the shell script you can put the help desk in charge of creating new accounts which will finally allow you to work uninterrupted and complete your server deployments on time.

# This script creates a new user on the local system.
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

# Verify if passwd command was succesful
if [[ "$?" -ne 0 ]]
then
        echo "Unsuccesful password set."
        exit 1
else
        echo "Password succesfully set."
fi

# Force password change (good practice)
passwd -e $USERNAME

# Display the username, password, and host where the user was created.
echo
echo "username: $USERNAME"
echo
echo "password: $PASSWORD"
echo
echo "host: $HOSTNAME"

# End of script, exit succesfully
exit 0
