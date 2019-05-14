param($action = "AllTheThings",[switch]$debug)


$name = "Golden Ticket"
$version = "1.0"
$lastmodified = "05/05/2019"


function GetItems
{
    #Get all the items we want to operate on

    #Just an array
    $items = "192.168.1.2", "192.168.1.7", "TACO-COMPUTER"

    #Import from a CSV
    #$items = Import-CSV -Path .\input.csv -Header

    #Get a list of computers from AD
    #Import-Module ActiveDirectory
    #$items = Get-ADComputer -Filter 'Name -like "SERVER*"' -Properties IPv4Address | FT Name,DNSHostName,IPv4Address -A

    #Get them from a text file
    #$items = Get-Content .\Computers.txt
    
    
    return $items
} 

function Operate($oneItem)
{
    #Operate on one item
    Write-Host "Operating on item: " $oneItem


    #Reboot it
    #shutdown -r -t 0 /f /m $oneItem

    #Query the registry (What edition of Windows are we running?)
    #reg query "$oneItem\HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName

    #Disable the computer
    #Import-Module ActiveDirectory
    #Set-ADComputer -Identity $oneItem -server MYDC -Enabled:$false

    #
    #Send-MailMessage
}



function OperateOnAllTheThings()
{
    #Go through our array of things and operate on each one.

    $items = GetItems
    foreach($item in $items)
    {
        Operate($item)
    }
}

$transcriptName = ".\" + $name + "-" + (Get-Date -f yyyy-MM-dd) + ".log"
Start-Transcript -Path $transcriptName
Write-Host "Name: " $name
Write-Host "Version: " $version
Write-Host "Last Modified: " $lastmodified


switch($Action)
{
    RebootComputers  { RebootComputers  }
    Restore  { Restore  }
    Backup  { Backup  }
    AllTheThings { OperateOnAllTheThings }
}


Stop-Transcript
