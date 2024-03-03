# user-wrangler

## About

This project showcases a collection of shell scripts designed to automate user account management on a local system. It offers functionalities for both user creation and removal, prioritising security and data preservation throughout the process.

## Usage:

This usage section provides clear instructions for running the scripts on an **Ubuntu** system.

**Clone the Repository**:
```
Bash
git clone https://sebwylleman/shell-yeah.git
```

**Navigate to the Directory**:
```
Bash
cd user-account-management
```
**Grant Executable Permissions (if necessary)**:

The scripts might need executable permissions for the script to run properly. You can grant them using the following command:
```
Bash
chmod +x setup-local-user.sh new-user-setup.sh (and any other scripts in the repository)
```
**Execute the Script**:

The specific command to execute the script will depend on the functionality you want to use (create user, disable user, etc.)  Refer to the script's comments within the repository for specific usage instructions.

**Note**:  Remember to run the scripts with sudo privileges to execute system administration commands like *useradd* and *userdel*

Example:
```
Bash
sudo setup-local-user.sh username "Optional Comment"
```
Replace username and "Optional Comment" with your desired values.

### Key Learnings:

**Shell Scripting**: Developed essential scripting skills like user input validation, conditional statements, file manipulation, and user account management functions.
**Security**: The script enforces security best practices by:
- Requiring superuser privileges for execution.
- Generating strong, random passwords for new accounts.
- Not echoing passwords to the console.
- Enforcing password change on the first login.
  
**System Administration**: The project involved interacting with core system administration commands like *useradd*, *passwd*, *userdel*, and *chage*.

### Functionalities:

**Secure User Provisioning**: Creates new user accounts with customisable comments and enforces strong password policies.
**Account Disabling**: Safely disables existing user accounts while preserving their home directories.
**Optional User Deletion**: Provides an option for permanent user deletion with safeguards to prevent accidental removal of critical accounts.
**Optional Home Directory Archiving**: Offers the ability to create an archive of the user's home directory before deletion (if the deletion option is chosen).

