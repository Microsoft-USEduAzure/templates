# ==========================================================================
# create and add the self-signed certificate to the local certificate store.  
# MAKE SURE TO RUN THE FOLLOWING COMMANDS W/ADMIN PERMISSION
# ==========================================================================
# Prerequisites:
#   Login-AzureRmAccount
#   Get-AzureRmSubscription
#   Select-AzureRmSubscription -Subscriptionid "9d7135b4-971c-4888-a3e6-f9e45a21d7dd"

# ===============================================================
# Modify the following variables to suit the deployment
# ===============================================================

$certDNSName = "*.cadoe4321.com"
$certFilePath = "C:\mycert.pfx"


$newCert = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName $certDNSName

# get certificate password from user
$pwd = Read-Host "Enter password for certificate:" -AsSecureString

# export certificate
Export-PfxCertificate -cert $newCert -FilePath $certFilePath -Password $pwd
