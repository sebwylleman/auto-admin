#!/bin/bash

# This script verifies the identity of the user running it by checking 
# both the User ID (UID) and username.

# It performs the following actions:
# 1. Displays the UID of the current user.
# 2. Checks if the user's UID matches a predefined value (configurable).
#    - If there's a mismatch, it exits with an error message.
# 3. Retrieves the username using the `id` command.
#    - If the `id` command fails, it exits with an error message.
# 4. Optionally checks if the username matches another predefined value.
#    - If there's a username mismatch (and username check is enabled), 
#      it exits with an error message.

# This script can be used to restrict access to the script based on 
# specific user credentials (UID and/or username). 

# Edit the variables `UID_TO_TEST_FOR` and `USER_NAME_TO_TEST` to customise 
# the expected UID and username for allowed execution.

echo "Your UID is ${UID}"

UID_TO_TEST_FOR='1000'

if [[ "${UID_TO_TEST_FOR}" -ne "${UID}" ]]
then
        echo "Your UID does not match ${UID_TO_TEST_FOR}"
        exit 1
fi

USER_NAME=$(id -un)

if [[ "${?}" -ne 0 ]]
then
        echo "id command did not execute succesfully"
        exit 1
fi

echo "Your username is ${USER_NAME}"

# Display if the user is 'user1'
USER_NAME_TO_TEST="user1"

if [[ "${USER_NAME_TO_TEST}" = "${USER_NAME}" ]]
then
        echo "Your username matches ${USER_NAME_TO_TEST}"
fi

if [[ "${USER_NAME_TO_TEST}" != "${USER_NAME}" ]]
then
        echo "Your username doesn't match ${USER_NAME_TO_TEST}"
        exit 1
fi

exit 0
