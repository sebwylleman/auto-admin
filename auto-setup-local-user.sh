# Goal:
# The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on.

# Scenario:
# The help desk team has been using the "add-local-user.sh" script you created.  They're really happy that they don't have to wait on you to create new accounts. :-)  However, they would like for you to make a couple of changes to the script when you get a chance.

# They're tired of coming up with a unique password for each user they create.  As a matter of fact, Jim keeps using "password" as the password for every account.  They think it would be great if the script automatically generated a password for each new account.  That way Jim and the rest of the team won't have to even think about passwords any longer.

# Also, they think it would be a little more efficient if they could just specify the account name and account comments on the command line instead of being prompted for them.  They already know what they are going to type so they would just rather type it all in at one time.

# Since you're happy that you're not the one creating all the new accounts any longer, you decide to accommodate their requests.  (You're so nice!)

# Shell Script Requirements:
# You have your requirements from the "add-local-user.sh" script you created.  You decide to use those as the basis for your new requirements.  You come up with the following list.

# The script:

# Is named "add-new-local-user.sh".  (You add the word new to distinguish it from the original script.)

# Enforces that it be executed with superuser (root) privileges.  If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1.

# Provides a usage statement much like you would find in a man page if the user does not supply an account name on the command line and returns an exit status of 1.

# Uses the first argument provided on the command line as the username for the account.  Any remaining arguments on the command line will be treated as the comment for the account.

# Automatically generates a password for the new account.

# Informs the user if the account was not able to be created for some reason.  If the account is not created, the script is to return an exit status of 1.

# Displays the username, password, and host where the account was created.  This way the help desk staff can copy the output of the script in order to easily deliver the information to the new account holder.

#!/bin/bash

# Enforces execution only from the superuser or root user
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

