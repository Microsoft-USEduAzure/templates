# Prerequisites:
#   Login-AzureRmAccount
#   Get-AzureRmSubscription
#   Select-AzureRmSubscription -Subscriptionid "GUID of subscription"
#  
$appGatewayName = "WUS-NP-AG-WAF"
$appGatewayResourceGroup = "CADOE" 
$probeName = "probe01"
$probeHostName = "helloworld.cadoe4321.com"
$probePath = "/"
# get the existing gateway
$gateway = Get-AzureRmApplicationGateway -Name $appGatewayName -ResourceGroupName $appGatewayResourceGroup
# add the probe to the gateway
$gateway = Add-AzureRmApplicationGatewayProbeConfig -ApplicationGateway $gateway `
				-Name $probeName `
				-HostName $probeHostName `
				-Path $probePath `
				-Protocol Http -Interval 30 -Timeout 120 -UnhealthyThreshold 8

# add the probe to the back-end pool setting configuration and time-out
$probe = Get-AzureRmApplicationGatewayProbeConfig -ApplicationGateway $gateway -Name $probeName 
				
$gateway = Set-AzureRmApplicationGatewayBackendHttpSettings -ApplicationGateway $gateway `
				-Name $gateway.BackendHttpSettingsCollection.name `
				-Probe $probe `
				-Port 80 -Protocol Http -CookieBasedAffinity Disabled -RequestTimeout 120

# remove a probe
# $gateway = Remove-AzureRmApplicationGatewayProbeConfig -ApplicationGateway $gateway -Name $gateway.Probes.name

# save the configuration to the gateway
Set-AzureRmApplicationGateway -ApplicationGateway $gateway	

Get-AzureRmApplicationGateway -Name "WUS-NP-AG-WAF" -ResourceGroupName "CADOE"

