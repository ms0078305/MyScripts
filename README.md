# MyScripts
Public Access 
This script is written by me to check telnets for N number of hosts and also to check latency by using average ping response time.
This has 2 parts 1 shell script and another supporting property file.

The shell script reads the contents of property file line by line to produce a result of telnet and ping commands.
The data used in the property file is dummy from 1 of my practise enviornments and not related to any client system.


I had used this to test all the end point URL's in OSB approx 150+ which helps me to debug issues very quickly whichever were related to slow response or any failures from business services. 
This can be used in any unix flavoured OS with minor corrections as required to check telnet for Number of hosts.

Tip :-  I had timed this script to run every 5 mins using crontab . it can be timed using any scheduling utility like IWS,OEM ,Jenkins etc
        I had also put a second crontab to delete the housekeeping files older than 15 days which runs every midnight
        
        
        */5 * * * *  /u01/products/TelnetCheck.sh
        0 0 * * * find /u01/products/ -name "TelnetCheckProd*.log" -mtime +15 -exec rm -f {} \;
        
        Thanks for reading my post . In case of any issues please drop a mail to mayank_satra@yahoo.co.in
