#script that automate backups for /home directory
#--------------------------------------------------------------------------------

#!/bin/bash

# Configuration
backup_directory="/home/kali/Downloads"
# the backup process will be once a year 
timestamp=$(date +"%Y")
backup_file="home_backup_${timestamp}.tar.gz"
home_directory="/home"

# Create backup
echo "Creating backup of /home directory..."
tar -czf "${backup_directory}/${backup_file}" -C "${home_directory}" .

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful. Archive saved to: ${backup_directory}/${backup_file}"
else
    echo "Backup failed. Please check for errors."
fi


