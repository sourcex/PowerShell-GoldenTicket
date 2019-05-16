param($action = "AllTheThings",[switch]$debug)


$name = "Golden Ticket"
$version = "1.0"
$lastmodified = "05/15/2019"


function GetItems
{
    #Get all the items we want to operate on

    #Just an array
    $items = "192.168.1.1", "192.168.1.7", "TACO-COMPUTER", "10.11.1.1", "10.6.1.1"

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


    #Better than Ping
    $result = Test-Connection $item -Count 1
    if($result)
    {
        Write-Output $item | Out-File -NoClobber ReachableComputers.txt
    }

    #Reboot it
    #shutdown -r -t 0 /f /m $oneItem

    #Query the registry (What edition of Windows are we running?)
    #reg query "$oneItem\HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName

    #Disable the computer
    #Import-Module ActiveDirectory
    #Set-ADComputer -Identity $oneItem -server MYDC -Enabled:$false

    #Send an email
    #Send-MailMessage

    #Copy a file
    #Copy-Item -Path c:\temp\someMSI.msi -Destination \\$oneItem\c$\temp

    #Run a script
    #psexec $oneItem -u USER -p PASSWORD \\SERVER\FIXTHINGSCRIPT.cmd

    #Wrap your stuff in an executable 7Z and run it on that box over there
    #psexec \\$oneitem -c LOCALBINARY.exe
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
