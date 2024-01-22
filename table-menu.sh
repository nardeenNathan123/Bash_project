#!/bin/bash
select val in "Insert into table" "Update Table" "De1m Table"  "search in table" "Exit"

do
    case $REPLY in 
    1)
    
    #cd ..;
    clear
    source ./insertTabledata.sh
    ;;
    2)
    
    source ./updateDataintable.sh
    clear
    #cd .. ;
    
    ;;
    3)
    
    source ./delete_from_table.sh
    clear
    #cd .. ;
    
    ;;
    4)
    clear
    source ./select_from_table.sh
    #cd ..;
    
    ;;
    5)
    clear
    #cd ..;
    echo "GoodBye :)" ; break 100
    ;;
     *) 
      echo -e "\e[31mNot in menu, please enter a valid choice\e[0m";;

    esac 
done
