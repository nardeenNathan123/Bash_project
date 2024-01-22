#!/bin/bash
read -p "Enter database you want to connect with: " connect_db

while [ ! -e "db/$connect_db/" ]
do
    echo -e "\e[31mdatabase not found enter the name again\e[0m"
    read connect_db
done

read -p "Enter table name : " table_name

while [ ! -e "db/$connect_db/$table_name" ]
do
    echo -e "\e[31mtable not found enter the name again\e[0m"
    read table_name
done

clear
read -p "Enter the data you want to find it " id

tail -n +3 "db/$connect_db/$table_name" | grep "$id" 


if [ $? -ne 0 ]; then
    echo -e "\e[31m************* Record not found for $id. ****************\e[0m"
fi

select rl in "go back to table operation menu" "go back to table menu"
do
   case $REPLY in 
     1) 
     source ./menuabledata.sh
     ;;
     2)
      source ./minuofTable.sh
     ;;
     *) 
     echo -e "\e[31mNot in menu, please enter a valid choice\e[0m";;
     esac
     
done
