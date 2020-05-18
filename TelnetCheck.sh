#/bin/bash

export DateStamp=`echo -e $(date '+%d%m%Y')`
export TodayLogFile=TelnetCheckProd_$DateStamp.log
>> $TodayLogFile
file="TelnetChecks.properties"
echo -e "\n\n------------------------New Iteration `date` -----------------------" | tee -a $TodayLogFile
while IFS= read -r line
do
        # display $line or do somthing with $line
        export BackEndName=`echo $line | awk '{ print $1 }'`
        export IP=`echo $line | awk '{ print $2 }'`
        export Port=`echo $line | awk '{ print $3 }'`

        echo -e "############################################################################" | tee -a $TodayLogFile
        #CheckOutput=`echo -e '\x1dclose\x0d' | telnet $IP $Port`
        CheckOutput=`echo -e '\x1dclose\x0d' | timeout 2 telnet $IP $Port`
        CheckPing=`ping -c 5 $IP | grep rtt | awk -F "/"  '{ print $5 }'`
        if echo "$CheckOutput" | grep -q "Connected to" ; then
             echo "INFO: Backend Name = $BackEndName" | tee -a $TodayLogFile
             echo "INFO: IP details = $IP" | tee -a $TodayLogFile
             echo "INFO: PORT details = $Port" | tee -a $TodayLogFile
             echo "INFO: Connection is established to target host $IP which belongs to backend $BackEndName at `date`" | tee -a $TodayLogFile
             echo "INFO: Average response time for 5 pings to host $IP is $CheckPing ms" | tee -a $TodayLogFile
             echo -e "############################################################################\n\n" | tee -a $TodayLogFile
        else
             echo "ERROR: Backend Name = $BackEndName" | tee -a $TodayLogFile
             echo "ERROR: IP details = $IP" | tee -a $TodayLogFile
             echo "ERROR: PORT details = $Port" | tee -a $TodayLogFile
             echo "ERROR: Connection is not established to target host which belongs to backend $BackEndName at `date`" | tee -a $TodayLogFile
             #echo "ERROR: The error for the telnet command was $CheckOutput"  | tee -a $TodayLogFile
             echo "ERROR: Average response time for 5 pings to host $IP is $CheckPing ms" | tee -a $TodayLogFile
             echo -e "############################################################################\n\n" | tee -a $TodayLogFile
        fi
        export BackEndName=''
        export IP=''
        export Port=''
        export CheckOutput=''
        export CheckPing=''
done <"$file"
