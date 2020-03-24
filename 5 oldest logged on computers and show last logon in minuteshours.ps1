$ADComputers = Get-ADComputer -Filter * -Properties lastLogon
$list = @()
foreach ($ADComputer in $ADComputers){

$LastLogon = [datetime]::FromFileTime($ADComputer.lastLogon)
#$pwdLastset2 = $ADUser.passwordLastSet

$LastLogonAge = $(Get-Date) - $LastLogon
if($ADComputer.LastLogon -eq 0){

    $LstlgnInMinutes = "NA"
    $LstlgnInHours = "NA"
    $LstlgnInSeconds = "NA"
    }
else {

$LstlgnInMinutes = [int]$LastLogonAge.TotalMinutes
$LstlgnInHours = [int]$LastLogonAge.TotalHours
$LstlgnInSeconds = [int]$LastLogonAge.TotalSeconds
$LstlgnInDays = [int]$LastLogonAge.TotalDays
}

$list += [PSCustomObject]@{
    
    DN = $ADComputer.DistinguishedName
    LastlgnLastSet = $ADComputer.pwdLastSet
    LastlgnAgeInDays = $LstlgnInDays
    LastlgnAgeInMinutes = $LstlgnInMinutes
    LastlgnAgeInHours = $LstlgnInHours
    LastlgnAgeInSeconds = $LstlgnInSeconds
    }
if($LstlgnInMinutes -gt 1000){
Write "$($ADComputer.DistinguishedName) has logged on that is older then 10,000 minutes ($LstlgnInMinutes)"
}

#if ($ADComputer.lastlogon -gt 100){disable-ADComputer $identity}
#make $identity variable in this case

}
$list | Sort-Object LastLogon | Select-Object -Last 10 | Format-Table

