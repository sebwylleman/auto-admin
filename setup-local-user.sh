#!/bin/bash

#Goal:
# The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on.

# Scenario:
# Imagine that you're working as a Linux System Administrator for a fast growing company. The latest company initiative requires you to build and deploy dozens of servers. You're falling behind schedule and are going to miss your deadline for these new server deployments because you are constantly being interrupted by the help desk calling you to create new Linux accounts for all the people in the company who have been recruited to test out the company's newest Linux-based application.
# In order to meet your deadline and keep your sanity, you decide to write a shell script that will create new user accounts. Once you're done with the shell script you can put the help desk in charge of creating new accounts which will finally allow you to work uninterrupted and complete your server deployments on time.

# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges, run: `sudo ./setup-local-user.sh`

# Get the username (login).

# Get the real name (contents for the description field).
# Get the password.
# Create the user with the password.
# Check to see if the useradd command succeeded.
# Set the password.
# Check to see if the passwd command succeeded.
# Force password change on first login.
# Display the username, password, and the host where the user was created.