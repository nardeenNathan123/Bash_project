#!/bin/bash
if [ ! -e "db" ];then
   mkdir "db" 
echo -e "\e[32m<<<<<<<<<<<<<<<<< database folder created >>>>>>>>>>>>>>>>>\e[0m"
fi 
 


select var in "Create database" "list database" "Connect database" "Delete database" "Exit"
do 
    case $REPLY in 
    1)
    	clear
        read -p "Enter your database name : " db_name
        db_name=`echo $db_name | tr " " "_"` 
        if [[ $db_name =~ ^[a-zA-Z]{1}$ ]];then
           echo -e "\e[31mDatabase must contain at least 2 characters .. press 1 to enter the name again\e[0m"
        elif [[ ${#db_name} -gt 20 ]];then
           echo -e "\e[31mTo much name .. press 1 to enter name again\e[0m"  
        elif [[ $db_name = [0-9]* ]];then
            echo -e "\e[31mDatabase cant start with number .. press 1 to enter name again\e[0m"  
        elif [[ $db_name = "" ]];then
            echo -e "\e[31mEmpty name ! .. press 1 to enter name again\e[0m" 
         elif [[ $db_name =~ ['!@#$%^&*:/\\()+'] ]];then
            echo -e "\e[31mDatabase cant contain special characters .. press 1 to enter name again\e[0m"  
        else
            if [[ -e db/$db_name ]];then
            echo -e "\e[31mThis Name already exist press 1 to enter name again\e[0m"

            else 
            mkdir db/$db_name  
            echo -e "\e[32m<<<<<<<<<<<<<<<<< your database created >>>>>>>>>>>>>>>>>\e[0m"
            
            source menu.sh
            fi  
        fi  
    ;;   
    2)
    clear
    source ./listDB.sh
    ;;
    3)
    clear
    source ./connectData.sh
    ;;
    4)
    clear
    source ./deleteDB
    ;; 
    5)
     echo "Get out"
     break 20
    ;;
    *) 
        echo -e "\e[31mNot in menu, please enter a valid choice\e[0m"
        ;;
    esac 
done    
    
