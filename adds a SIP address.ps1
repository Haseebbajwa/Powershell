$ADUsers = Get-ADUser -filter *  -properties * -Searchbase "OU=test,DC=ad,DC=mov,DC=se"


ForEach($ADUser in $ADUsers){


    $SIP1 = ($ADUser.proxyAddresses | ? {$PSItem -cmatch "SIP:"})
    

if (!$SIP1){

    $SIP1 = ($ADUser.proxyAddresses | ? {$PSItem -cmatch "SMTP:"}).replace("SMTP:", "SIP:")

#Write-Host "$($ADUser.Name) does not have SIP proxy Configured")
Set-ADUser $ADUser -Add @{proxyAddresses = $SIP1}
}
}