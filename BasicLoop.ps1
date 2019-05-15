#BasicLoop - Demo a basic loop operation and output computers that are on
   
$transcriptName = ".\BasicLoop-" + (Get-Date -f yyyy-MM-dd) + ".log"
Start-Transcript -Path $transcriptName

   
$items = "192.168.1.1", "192.168.1.7", "TACO-COMPUTER", "10.11.1.1", "10.6.1.1"
foreach($item in $items)
{
    Write-Host "Operating on item: " $item

    #Better than Ping
    $result = Test-Connection $item -Count 1
    if($result)
    {
        Write-Output $item | Out-File -NoClobber ReachableComputers.txt
    }

}

Stop-Transcript
