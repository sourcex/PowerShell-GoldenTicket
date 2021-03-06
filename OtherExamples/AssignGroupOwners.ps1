<# Assign Owners to groups based on a CSV.

Input = file called groupowners.csv in the same directory as the script.
Format:

Name,Owner
SOMEGROUP,A Person
    


#>

import-module ActiveDirectory

$domain = "DOMAIN.LOCAL"



if(!(Test-Path groupowners.csv)) { Return }
$csv = Import-Csv "groupowners.csv"

foreach($line in $csv)
{
    $group = $line.Name
    $g = Get-ADGroup $group -Server $domain -Properties ManagedBy
    Write-Host "Group: $($g.Name)"
    
    $user = $line.Owner
    
    $u = Get-ADUser -Filter 'Name -like $user' -Server $domain
    Write-Host "User: $($u.Name)"

    if($g -eq $null) { continue }
    if($u -eq $null) { continue }
    
    Set-ADGroup $g -server $domain -ManagedBy $u.DistinguishedName

}