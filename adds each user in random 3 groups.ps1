$Groups = Get-ADGroup -SearchBase "OU=Group,DC=ad,DC=mov,DC=se" -filter *
$adusers = Get-ADUser -filter *
foreach ($aduser IN $adusers) {
$RandomGroups = $Groups | Get-Random -count 3
foreach ($RandomGroup in $RandomGroups){
Add-ADGroupMember -Identity $RandomGroup -Members $aduser}
}