# Reboot all the things!
# RebootAllTheThings.ps1

import-module activedirectory

$OUs = "OU=Computers,OU=ou1,OU=Sites,DC=domain,DC=com","OU=Computers,OU=ou2,OU=Sites,DC=domain,DC=com","OU=Computers,OU=ou3,OU=Sites,DC=domain,DC=com"
$excludeComputers = "TEST1","TEST2"

function GetDomainForDN
{
    param($DN)

    $split = $DN -Split ",DC="
    $size = $split.Length
    if ($size -eq 3) { return "domain.local" }  
    $domain = $split[1]   
    return $domain
}

function RebootComputer
{
    param($computer)
    Shutdown -r -t 5 -f -m $computer
}

foreach($OU in $OUs)
{
    
    $domain = GetDomainforDN($OU)
    
    $computers = Get-ADComputer -SearchBase $OU -Server $domain -Filter *
    $count = $computers.Count
    Write-Host "OU: $OU : $count"
    
    foreach($computer in $computers)
    {
        foreach($excludecomputer in $excludeComputers)
        {
            if($computer.Name -eq $excludeComputer) { Write-Host "Skipping computer: $($computer.name)" ;  $skip = $true ;continue }
        }
        
        if($skip) { $skip = $false ; continue }
    
        if(Test-Connection $computer.Name -quiet)
        {
            Write-Host "Computer is up: $($computer.Name)"
            RebootComputer($computer)
        } else
        {
            Write-Host "Computer is not up: $($computer.Name)"
        }
    }
}