# GetComputerList.ps1

Import-Module ActiveDirectory

$sourceOU = "OU=Computers,DC=DOMAINNAME,DC=local"
$outputFile = "Computers-$(get-date -format yyyy-m-d-hh-mm).csv"

# Get-ADComputer -Server $domainNETBIOS -SearchBase $dn -Properties Name,OperatingSystem -Filter 'OperatingSystem -like "Windows Server*"'
$computer = Get-ADComputer -searchBase $sourceOU -Properties Name, OperatingSystem
Export-Csv -NoTypeInformation -Path $outputFile