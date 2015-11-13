#!/bin/bash

################################################################################
##  This script is using to get the duplicate entires in contact group        ##
##  Author : Adishesha                                                        ##
##  Email ID : adis0001@synchronoss.com                                       ##
################################################################################

clear
display_usage() {
        echo "This script must be run with input file."
        echo -e "\nUsage:\n$0 [Input file] \n"
        }

if [  $# -le 0 ]
        then
                display_usage
                exit 1
        fi

START_TIME=$(date +%s)
if [ -f $1 ] ;
then
        cat $1 | grep "itemGuid" > TEMP_FILE
        cat  TEMP_FILE | awk '!x[$3]++' > PROCESSED_FILE
        diff TEMP_FILE PROCESSED_FILE > New_Processed_File
        awk -F'"' '{print $11 $12}'  New_Processed_File > Item_Guid
        sed '/^\s*$/d' Item_Guid > Item_Guid_file1
        rm -f TEMP_FILE New_Processed_File Item_Guid
else
        echo " $1 File Not found"

fi


echo "Please wait if the input file is big in size, It will take some time ...........!!"
a=1
while read line
do
echo $line | sed 's/^\(.\{18\}\)/\1-/' | sed 's/^\(.\{23\}\)/\1-/' | sed 's/^\(.\{28\}\)/\1-/'  | sed 's/^\(.\{33\}\)/\1-/' | sed 's/itemGuid=//;s/"//'  >>  Duplicate_Groups.XML
printf " \rTotal Number of Duplicate IDs : \e[1;92m$a\e[0m"
a=`expr $a + 1`
done < "Item_Guid_file1"
rm -f Item_Guid_file1 PROCESSED_FILE
echo ""
echo -e "\e[1;92mDone .....!!\e[0m"

END_TIME=$(date +%s)
Diffrence=$(($END_TIME - $START_TIME))
echo -e "Total time taken to Process the file : \e[1;94m$((Diffrence /60))\e[0m Min's and  \e[1;94m$((Diffrence % 60))\e[0m Sec's elapsed."




wellcome to git aveen