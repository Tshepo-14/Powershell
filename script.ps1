# Set the number of days before password expiration to send notification
$DaysBeforeExpiration = 10

# Import the Active Directory module
Import-Module ActiveDirectory

# Set the email parameters
$From = "from@gmail.com"

$SmtpServer = "smtp.office365.com"
$SmtpPort = 587  # Use port 587 for SMTP submission with TLS
$SmtpUsername = "name@gmail.com"
$SmtpPassword = "password" | ConvertTo-SecureString -AsPlainText -Force
$SmtpCredential = New-Object System.Management.Automation.PSCredential ($SmtpUsername, $SmtpPassword)

# Create SmtpClient object
$SmtpClient = New-Object System.Net.Mail.SmtpClient($SmtpServer, $SmtpPort)
$SmtpClient.EnableSsl = $true
$SmtpClient.Credentials = $SmtpCredential

# Get the current date
$CurrentDate = Get-Date

# Get all users from Active Directory
$Users = Get-ADUser -Filter *

foreach ($User in $Users) {
    # Check if the user account is enabled
    if ($User.Enabled -eq $true) {
        # Check if the user has an email address and password expiration date
        if ($User.EmailAddress -ne $null -and $User."msDS-UserPasswordExpiryTimeComputed" -gt 0) {
            $DaysUntilExpiration = [math]::Round(([datetime]::FromFileTime($User."msDS-UserPasswordExpiryTimeComputed") - $CurrentDate).TotalDays)
            
            # Check if the password expiration is within the specified period
            if ($DaysUntilExpiration -lt $DaysBeforeExpiration) {
                $Body = "Dear $($User.DisplayName),`r`n`r`n<br><br>"
                $Body += "Your password will expire in $DaysUntilExpiration days. <br> Please change your password before it expires to avoid problems accessing your work services.<br>"
               

                $Subject = "Your password will expire in $DaysUntilExpiration days"

                # Send email notification
                $MailMessage = New-Object System.Net.Mail.MailMessage
                $MailMessage.From = $From
                $MailMessage.To.Add($User.EmailAddress)
		

                $MailMessage.Subject = $Subject
                $MailMessage.Body = $Body
                $MailMessage.IsBodyHtml = $true
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

                $SmtpClient.Send($MailMessage)

		#Duplicate this to send to internalIT email

		$MailMessages = New-Object System.Net.Mail.MailMessage
		$MailMessages.From = $From
		$MailMessages.To.Add($SmtpUsername)


		$MailMessages.Subject = $Subject
                $MailMessages.Body = $Body
                $MailMessages.IsBodyHtml = $true
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

                $SmtpClient.Send($MailMessages)
		

            }
        }
    }
}

