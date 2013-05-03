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
        #strip trailing slash if any from provided parameters
        $sourceDir = $Param1 -replace '\\$',''
        $targetDir = $Param2 -replace '\\$',''
        $sdLength = $sourceDir.length
        $daysOlder = $Param3
        $logFile = (get-date -UFormat "%m%d%Y%H%M%S")+"archive-files.log"
        New-Item -Path $sourceDir -Name $logFile -ItemType File
        $logFPath = $sourceDir+"\"+$logFile
        
        
    }
    Process
    {
        echo "*************   Starting Archive Process *************"|Out-File -FilePath $logFPath -Append
        #find all sub directories under the source head and add each directory to array
        $sourceDirs = get-childitem -Path $sourceDir -recurse |?{ $_.PSIsContainer }| foreach-object -process { $_.FullName }
        
        $sDArray = @()
        foreach($sDir in $sourceDirs){
            $sDArray += $sDir
        }
        echo $sDArray

        #Main archive section
   <#     foreach($sDir in $sourceDirs) {
            
            $suPath= $targetDir + $sDir.Substring($sdLength)

            # check to see if subdirectory has been created. if not create.
            $testTarget= Test-Path -PathType Container $suPath
            if($testTarget -eq $false) {
                echo "Creating $suPath"|Out-File -FilePath $logFPath -Append
                New-Item -Path $suPath -ItemType Directory
            }
            # find files older than supplied value and move them to archive path
            # http://stackoverflow.com/a/5912122 Mathey Steeples solution
            Get-ChildItem -Path $sDir | Where-Object {$_.LastWriteTime -lt (get-date).AddDays(-$daysOlder)}|Move-Item -Destination $suPath
    } #>

 

    }
    End
    {
        echo "*************   Completed Archiving *************"|Out-File -FilePath $logFPath -Append
    }
}