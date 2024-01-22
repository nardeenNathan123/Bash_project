#!/bin/bash

clear

db_folder="db"

echo -e "\e[34m<<<<<<<<<<<<<<< Here are your DataBases >>>>>>>>>>>>>>>>>>\e[0m"
ls -d "$db_folder"/* | awk -F/ '{print $NF}'


select reply in "Go back to database Menu" "Exit"
do
    case $REPLY in
        1) 
            clear
            source ./createDatabase.sh
            break
            ;;
        2)
            echo "Get out"
            break 20
            ;;
        *) 
            echo "not in menu"
            ;;
    esac
done

