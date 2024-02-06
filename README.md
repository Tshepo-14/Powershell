Password Expiration Email Notification Script
This PowerShell script is designed to automatically send email notifications to users in Active Directory when their passwords are about to expire. 
The script calculates the number of days until password expiration for each user and sends an email if the remaining days are less than a specified threshold.

Usage
Set Parameters: Modify the script to set the necessary parameters such as the number of days before password expiration to send notifications, email sender and SMTP server credentials.


![image](https://github.com/Tshepo-14/Powershell/assets/51974901/91a4ceb0-494f-4170-9638-96fd1b3e9911)


1.Run the Script: Execute the PowerShell script on a machine with access to the Active Directory domain controller.


![image](https://github.com/Tshepo-14/Powershell/assets/51974901/ca8eed28-12f5-4059-843f-1f4893ec30a8)

Scheduled Execution: To automate the script's execution, schedule it to run periodically using Task Scheduler or any other scheduling mechanism supported by your operating system.
Features
Automatically retrieves user information from Active Directory.
Sends email notifications to users whose passwords are about to expire.
Supports customization of notification threshold and email content.
Requirements
PowerShell (5.1 or later)
Active Directory module installed (Import-Module ActiveDirectory)
License
This script is licensed under the MIT License.

Acknowledgements
This script was inspired by the need to proactively manage password expiration notifications in enterprise environments. Special thanks to the PowerShell community for valuable insights and contributions.

Author:Tshepo Molaoa
