#!/bin/bash
choices=("Insert into table" "Update Table" "Delete from Table"  "Back to Previous_Menu" "Exit")
select val in "${choices[@]}"
do
    case $val in 
    "Insert into table")
    clear;
   
    source insertTabledata.sh
    ;;
    "Update Table")
    clear;
    cd .. ;
    
    ;;
    "Delete from Table")
    clear;
    cd .. ;
    
    ;;
    "Back to Previous_Menu")
    clear;
    cd ..;
    
    ;;
    "Exit")
    clear ;
    #cd ..;
    echo "GoodBye :)" ; break 100
    ;;
     *) 
    echo "please enter a valid input";;
    esac 
done
