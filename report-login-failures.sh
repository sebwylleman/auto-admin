#/bin/bash

# Analyse Login Attempts Report for a CENTOS system. MUST HAVE SUPERUSER OR ROOT PRIVILEGES to display contents

# This script analyses a log file containing failed login attempts and generates a report summarising potentially suspicious activity. 
# If there are any IPs with over LIMIT failures, display the count, IP, and location.

MAX_LOGIN_ATTEMPTS='10'
LOG_FILE="${1}"

# Check if a log file was supplied as an argument.
if [[ ! -eq "${LOG_FILE}" ]]
then
    echo "Error: Please provide a log file path as an argument." >&2
    exit 1
fi
