<#
.Synopsis
   custom html report for windows disk space.
.DESCRIPTION
    custom html report for windows disk space.
.EXAMPLE
   Get-DiskReport -ComputerName "Server1","Server2" -Path C:\temp
#>
function Get-DiskReport
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelinebyPropertyName=$True)] $ComputerName,
        # Param2 help description
        $Path = "C:\Temp"
    )
    Begin {
        $updatedPath = $Path -replace '\\$',''
    }
    Process {
    foreach($node in $ComputerName){
            $outputFile = $($updatedPath + "\" + $node + ".html")
           
           #HTML Header
            $htmlHead = @"
             <!DOCTYPE HTML>
            <html lang="en">
            <head>
	            <meta charset="UTF-8">
	            <title>Drive Free Space Report - $node</title>
                <style type="text/css">
		            body {font-family:"Segoe-UI", Frutiger, "Frutiger Linotype", "Dejavu-Sans", "Helvetica Neue", Arial, sans-serif; background: #890000; color: #fff; }
		            html { font-size: 1.5em; }
                    th, td {padding: 10px;}
                    #container {width:800px; margin: 0 auto;}
                </style>
                <!--[if lt IE 9]><script src="dist/html5shiv.js"></script>
                <![endif]-->
            </head>
            <body>
            <div id="container">
	            <header>
		            <h2>Local Fixed Disk Report - $node</h2>
	            </header>
                <section>
                    <table>
                    <thead><tr><th>Drive</th><th>Size(GB)</th><th>Free Space (MB)</th></tr>
"@
            $timeStamp =  get-date -Format "MM/dd/yyyy hh:mm:ss"
            $driveSpace = gwmi win32_volume -ComputerName $node -Filter 'drivetype = 3' | select @{LABEL='Drive'; EXPRESSION={$_.driveletter}},
                @{LABEL='Size';EXPRESSION={[math]::truncate($_.capacity/1GB)} },
                @{LABEL='Free';EXPRESSION={[math]::truncate($_.freespace/1MB)} }
                foreach($row in $driveSpace) {
                    $htmlBody += "<tr><td>$($row.Drive)</td><td>$($row.Size)</td><td>$($row.Free)</td></tr>"
                }

            #html footer
            $htmlFooter = @"
                </table>
            </section>
            <footer>
                <hr>
                <p>$timeStamp</p>
            </footer>
            </div>
            </body>
            </html>
"@
            $fullHtml =  $htmlHead + $htmlBody + $htmlFooter
            out-file -InputObject $fullHtml -filepath $outputFile
            $htmlBody = ""

            }
    }
    End{}

}




        
        