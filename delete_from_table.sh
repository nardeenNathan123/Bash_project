#!/bin/bash
read -p "Enter database you want to connect with: " connect_db

while [ ! -d "db/$connect_db/" ]
do
echo -e "\e[31mdatabase not found enter the name again\e[0m"
    read connect_db
done

read -p "Enter table name : " table_name

while [ ! -f "db/$connect_db/$table_name" ]
do
    echo -e "\e[31mtable not found enter the name again\e[0m"
    read table_name
done

clear;
select rl in  "delete data from table" "delete only record by using ID"
do
case $REPLY in 

1)
echo -e "\e[31mare you sure to delete all data in table\e[0m"
select ol in "yes" "no"
do
case $REPLY in 
1)
sed -i '3,$d' "db/$connect_db/$table_name"
clear
echo -e "\e[32m~~~~~~~~~~the data deleted~~~~~~~~~~~~~\e[0m"
source ./table-menu.sh
;;
2)
source ./table-menu.sh
;;
esac
done

;;
2)
read -p "enter the Id of the record you want to delete : " id
while ! [[ $id =~ ^[0-9]*$ ]] || [[ $id =~ ['!@#$%^&*():_+'] ]] || [[ $id == "" ]] || [[ $id =~ [a-zA-z] ]]
	do
	echo -e "\e[31mInvalid value for the id! enter your value again\e[0m"
	read id
	done
    if [ `awk '(NR>2)' "db/$connect_db/$table_name"  | awk -F : ' {print $1}'| grep $id ` ]
then
echo -e "\e[31mAre you sure you want to delete this record $id\e[0m"
select rel in "Yes" "No" 
do 
    case $REPLY in 
    1)
   
    `sed -i '/^'$id'/ d' "db/$connect_db/$table_name"`;
    clear
    echo -e "\e[32m~~~~~~~~~~record was deleted successfully~~~~~~~~~~~~~~\e[0m";
    echo -e "\e[34mDo you want to see the file after delete ? "db/$connect_db/$table_name" Table??\e[0m";
        select relp in "Yes" "Back To Previous Menu"
        do  
            case $REPLY in
                1)
                   
                    clear
                    tail -n +3 "db/$connect_db/$table_name"
                    source ./table-menu.sh
                    
                    
                    # cd ..;
                    
                    ;;
                2)
                
                # cd ..;
                source table-menu.sh 
                ;;
                *) 
                echo -e "\e[31mNot in menu, please enter a valid choice\e[0m";;

            esac
        done
    ;;
    2)
    source ./table-menu.sh
        
    ;;
     *) 
    echo -e "\e[31mnot in menu\e[0m";;
    esac
done

else 
    echo -e "\e[31mNo record with ID : $id\e[0m"
    source ./table-menu.sh
fi
esac
done


