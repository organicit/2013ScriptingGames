#Organicit 2013 Scripting Games submissions

##Event 1

Dr. Scripto is in a tizzy! It seems that someone has allowed a series of application log files to pile up for around two years, and they’re starting to put the pinch on free disk space on a server. Your job is to help get the old files off to a new location. Actually, this happened last week, too. You might as well create a tool to do the archiving. The current set of log files are located in C:\Application\Log. There are three applications that write logs here, and each uses its own subfolder. For example, C:\Application\Log\App1, C:\Application\Log\OtherApp, and C:\Application\Log\ThisAppAlso. Within those subfolders, the filenames are random GUIDs with a .LOG filename extension. Once created on disk, the files are never touched again by the applications.Your goal is to grab all of the files older than 90 days and move them to \\NASServer\Archives - although that path will change from time to time. You need to maintain the subfolder structure, so that files from C:\Application\Log\App1 get moved to \\NASServer\Archives\App1, and so forth. Make those paths parameters, so that Dr. Scripto can just run this tool with whatever paths are appropriate at the time. The 90-day period should be a parameter too. You want to ensure that any errors that happen during the move are clearly displayed to whoever is running your command. If no errors occur, your command doesn’t need to display any output – “no news is good news.”


##Event 2

##Event 3

##Event 4

##Event 5

##Event 6