param($action = "AllTheThings",[switch]$debug)


$name = "Golden Ticket"
$version = "1.0"
$lastmodified = "05/05/2019"


function GetItems()
{
    #Get all the items we want to operate on


} 

function Operate($item)
{
    #Operate on one item

}



function OperateOnAllTheThings()
{
    #Go through our array of things and operate on each one.

    $items = Get-Items()
    foreach($item in $items)
    {
        Operate($item)
    }
}


Start-Transcript -Path ".\" + $name + ".log"
Write-Host $name
Write-Host $version
Write-Host $lastmodified



switch($Action)
{
    RebootComputers  { RebootComputers  }
    Restore  { Restore  }
    Backup  { Backup  }
    AllTheThings { OperateOnAllTheThings }
}


Stop-Transcript
