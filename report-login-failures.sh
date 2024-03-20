#/bin/bash

# Analyze Login Attempts Report

# This script analyses a log file containing failed login attempts and generates a report summarising potentially suspicious activity. 
#It helps identify IP addresses exhibiting an unusually high number of failed login attempts, which could be indicative of brute-force attacks or unauthorised access attempts.

# The script outputs a report in CSV format (Comma-Separated Values) with the following columns:

# Count: Number of failed login attempts from a specific IP address.
# IP: The IP address associated with the failed login attempts.
# Location: (Optional, depending on your log data) Geographic location associated with the IP address (may require additional tools or configuration).

# How to Use:
# Save this script as report-login-failures.sh (or your preferred name).
# Make the script executable using chmod +x report-login-failures.sh
# Run the script with the path to your login attempt log file as an argument:

# Check if a log file was supplied as an argument.
# Display the CSV header.
# Loop through the list of failed attempts and corresponding IP addresses.
# If the number of failed attempts is greater than the limit, display
# count, IP, and location.
