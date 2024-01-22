select vr in "create table" "remove table"    "show table" "go to database menu" "use table" "Exit"
      do
      case $REPLY in
      1)
      	clear
        source ./createTable.sh
      ;;
      2)
      	clear
        source ./delete_table.sh        
      ;;

      3)
      	clear
      	source ./list_tables.sh
      ;;
      4)
          clear
          source ./createDatabase.sh
      ;;
      5)
       clear
       source ./table-menu.sh
      ;;
     6)
     echo "good bye"
     break 20
     ;;
      *) 
       echo -e "\e[31mNot in menu, please enter a valid choice\e[0m"

        ;;

      esac
      done


      
