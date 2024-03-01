#!/bin/bash

# Display the UID and username of the user executing this script
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
