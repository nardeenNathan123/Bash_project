#!/bin/bash

read -p "Enter database you want to connect with: " connect_db
export connect_db

if [ -d db/$connect_db ]; then
    select vr in "create table" "remove table" "use table" "show table" "go to database menu" "exit"; do
        case $REPLY in
            1)	clear
                source ./createTable.sh
                ;;
            2)
            	clear
                source ./delete_table.sh
                ;;
            3)
            	clear
               source ./table-menu.sh
                ;;
            4)
            	clear
                source ./list_tables.sh 
                ;;
            5)
            	clear
                source ./createDatabase.sh
                ;;
            6)
            	clear
                break
                ;;
            *)
                echo -e "\e[31mNot in menu, please enter a valid choice\e[0m"
                ;;
        esac
    done
else
    echo -e "\e[31m<<<<<<<<<<<<<<< Database enterd not found >>>>>>>>>>>>>>>\e[0m"
    source createDatabase.sh
fi

