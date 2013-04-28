<#
.Synopsis
   Script to Archive logs
.DESCRIPTION
   Archive-Files takes user input being "Top Level" directory to archive, the "Destination target", and "Days Older Than" value.  It takes the first parameter and looks for files
   older than the 3rd parameter.  I archives the files in a compressed zip file in the same directory structure that was found on the source and date time stamps the zipped files.
.EXAMPLE
   Archive-Files "C:\Applicaiton\Logs" "\\NASServer\Archives" 90
#>
function Archive-Files
{
    [CmdletBinding()]
    Param
    (
        # Param1 parameter setting the top level path to be archived
        $Param1,

        # Param2 sets the desitination archive directory
        $Param2,

        # Param3 defines the "Files older than" value
        $Param3
    )

    Begin
    {
        $sourceDir = $Param1 -replace '\\$',''
        $sdLength = $sourceDir.length
        $targetDir = $Param2 -replace '\\$',''
        $daysOlder = $Param3
        
    }
    Process
    {
    #find all sub directories under the source head and add each directory to array
    $sourceDirs = get-childitem -Path $sourceDir -recurse |?{ $_.PSIsContainer }| foreach-object -process { $_.FullName }
    $sourceArray = @()
    foreach($sDir in $sourceDirs) {
        $suPath= $targetDir + $sDir.Substring($sdLength)
        echo $suPath
        $testTarget= Test-Path -PathType Container $suPath
        if($testTarget -eq $false) {
            New-Item -Path $suPath -ItemType Directory
        }
        # http://stackoverflow.com/a/5912122 Mathey Steeples solution
        Get-ChildItem -Path $sDir | Where-Object {$_.LastWriteTime -lt (get-date).AddDays(-$daysOlder)}|Move-Item -Destination $suPath

        
    }

    #loop through each directory in the array and move, compress, and delete files older than $Param3,
    #and add each files info to run log

    }
    End
    {
    }
}