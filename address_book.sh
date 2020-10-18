#!/bin/bash

function addToRecord()
{
        echo
        while true
        do
                echo "To add record to your address book, Enter the information in the below format"
                echo "format: \"Last name,first name,email,,city,zip-code,phone number\" (dont give any spaces)."
                echo "Example: bhargav,ajay,ajay812998@gmail.com,Hyderabad,zip-code,7674929172"
                echo "Want to quit, enter 'q'."
                read aInput
                if [ "$aInput" == 'q' ]
                        then
                        break
                fi
                echo
                echo $aInput >> addressbook.csv
                echo "Entry uptaded to the address book."
                echo
        done
}


function displayRecord()
{
        echo
        while true
        do
                echo "To display the record, enter last name of person (is case sensitive)."
                echo "Want to quit, enter 'q'."
                read dInput
                if [ "$dInput" == 'q' ]
                        then
                        break
                fi
                echo
                echo "Listing records for \"$dInput\":"
                grep ^"$dInput" addressbook.csv   # searching the lines by last name (the first field in the record)
                STATUS=`echo $?`
                if [ $STATUS -eq 1 ]
                        then
                        echo "Error no records found with the entered last name of \"$dInput\"."
                fi
                echo
        done
}


function editRecord()
{
        echo
        while true
        do
                echo "For edit a record, enter any search string, e.g. last name or email address (is case sensitive)."
                echo "If completed editing your address book, enter 'q' to quit."
                read eInput
                if [ "$eInput" == 'q' ]
                        then
                        break
                fi
                echo
                echo "Listing records for \"$eInput\":"
                grep -n "$eInput" addressbook.csv
                STATUS=`echo $?`
                if [ $STATUS -eq 1 ]
                        then
                        echo "No records found for \"$eInput\""
                else
                        echo
                        echo "Enter the line number (the first number of the entry) that you'd like to edit."
                        read lineNumber
                        echo
                        for line in `grep -n "$eInput" addressbook.csv`
                        do
                                number=`echo "$line" | cut -c1`
                                if [ $number -eq $lineNumber ]
                                        then
                                        echo "What would you like to change it to? Use the format:"
                                        echo "\"Last name,first name,email,city,zip-code,phone number\" (no quotes or spaces)."
                                        read edit
                                        lineChange="${lineNumber}s"
                                        sed -i -e "$lineChange/.*/$edit/" addressbook.csv
                                        echo
                                        echo "The change is successfully made."
                                fi
                        done
                fi
                echo
        done
}


function removeRecord()
{
        echo
        while true
        do
                echo "To remove or delete a record, enter any search string, e.g. last name or (is case sensitive)."
                echo "If you completed, enter 'q' to quit."
                read rInput
                if [ "$rInput" == 'q' ]
                        then
                        break
                fi
                echo
                echo "Listing records for \"$rInput\":"
                grep -n "$rInput" addressbook.csv
                STATUS=`echo $?`
                if [ $STATUS -eq 1 ]
                        then
                        echo "No records found for \"$rInput\""
                else
                        echo
                        echo "Enter the line number (the first number of the entry) of the record you want to remove."
                        read lineNumber
                        for line in `grep -n "$rInput" addressbook.csv`
                        do
                                number=`echo "$line" | cut -c1`
                                if [ $number -eq $lineNumber ]
                                        then
                                        lineRemove="${lineNumber}d"
                                        sed -i -e "$lineRemove" addressbook.csv
                                        echo "The record is successfully removed or deleted from the address book."
                                fi
                        done
                fi
                echo
        done
}


function sorting()
{

echo $(cat addressbook.csv | sort |awk '{print $0}')


}


echo
lastCharOfFile=`tail -c 1 addressbook.csv` # To check weather the .csv file ends with newline character
if [ -n "$lastCharOfFile" ]
        then
        echo >> addressbook.csv
fi
echo "Select What you want to do with the address book?"
echo "Enter Accordingly:"
echo "1) to add a record"
echo "2) to display 1 or more records"
echo "3) to edit a record"
echo "4) to remove a single record"
echo "5) to Sort"
echo
read input

case $input in
        1) addToRecord
                ;;
        2) displayRecord
                ;;
        3) editRecord
                ;;
        4) removeRecord
                ;;
        5) sorting
                ;;
        *) echo "Enter the Valid number"
                ;;

esac











