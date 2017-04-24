# MAKE SURE TO RUN THIS POWERSHELL SCRIPT AS ADMINISTRATOR
# Run the following first to establish connection to Azure:
#   Login-AzureRmAccount
#   Get-AzureRmSubscription
#   Select-AzureRmSubscription -Subscriptionid "5b70f1d4-1960-4241-9af7-6702b9a81ac8"

# ===============================================================
# Modify the following variables to suit the deployment
# ===============================================================
$gatewayResourceGroup = "CADOE" 
$appGatewayName = "WUS-NP-AG-WAF"
$certName = "mycert"
$certDNSName = "*.cadoe4321.com"
$certFilePath = "C:\temp\mycert.pfx"

		
# ==========================================================================
# create and add the self-signed certificate to the local certificate store.  
# ==========================================================================
#$newCert = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName $certDNSName

# get certificate password from user
$pwd = Read-Host "Enter password for certificate:" -AsSecureString
$plainPassword = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($pwd)) 

# export certificate
#Export-PfxCertificate -cert $newCert -FilePath $certFilePath -Password $pwd

# ===============================================================
# get the existing gateway
# ===============================================================
$gateway = Get-AzureRmApplicationGateway -Name $appGatewayName -ResourceGroupName $gatewayResourceGroup

# ==========================================================================
# configure SSL certificate for gateway
# ==========================================================================

# add certificate to the gateway
$gateway = Add-AzureRmApplicationGatewaySslCertificate -ApplicationGateway $gateway `
            -Name $certName `
            -CertificateFile $certFilePath `
            -Password $plainPassword
$appGatewayCert = Get-AzureRmApplicationGatewaySslCertificate -ApplicationGateway $gateway -Name $certName 

# add new front-end IP port - 443
$gateway = Add-AzureRmApplicationGatewayFrontendPort -ApplicationGateway $gateway -Name appGatewayFrontendHttpsPort -Port 443
$frontendPort = Get-AzureRmApplicationGatewayFrontendPort -ApplicationGateway $gateway -Name appGatewayFrontendHttpsPort 

# get existing front-end IP configuration because we're going to reuse the public IP address
$frontendIP = Get-AzureRmApplicationGatewayFrontendIPConfig -ApplicationGateway $gateway -Name appGatewayFrontendIP 


# add https front end listener
$gateway = Add-AzureRmApplicationGatewayHttpListener -ApplicationGateway $gateway `
            -Name appGatewayHttpsListener `
            -Protocol Https `
            -FrontendIPConfiguration $frontendIP `
            -FrontendPort $frontendPort `
            -SslCertificate $appGatewayCert
$listener = Get-AzureRmApplicationGatewayHttpListener -ApplicationGateway $gateway -Name appGatewayHttpsListener 

# get existing back-end IP address pool
$backendAddrPool = Get-AzureRmApplicationGatewayBackendAddressPool -ApplicationGateway $gateway -Name appGatewayBackendPool 

# get existing backend settings
$backendHttpSetting = Get-AzureRmApplicationGatewayBackendHttpSettings -ApplicationGateway $gateway -Name $gateway.BackendHttpSettingsCollection.name 

# create the load balancer routing rule that configure the load balancer behavior
$gateway = Add-AzureRmApplicationGatewayRequestRoutingRule -ApplicationGateway $gateway -Name rule02 -RuleType Basic -HttpListener $listener -BackendAddressPool $backendAddrPool -BackendHttpSettings $backendHttpSetting



# save the configuration to the gateway
Set-AzureRmApplicationGateway -ApplicationGateway $gateway	


