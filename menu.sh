select a in "go back to Database menu" "go back to Table menu" "Exit"
do
  case $REPLY in 
  1)
   clear
   source ./createDatabase.sh
  ;;
  2)
  clear
   source ./minuofTable.sh
  ;;
  3)
  echo "good bye :*"
  break 20
  ;;
  *)
  echo -e "\e[31mNot in menu, please enter a valid choice\e[0m"

  ;;
  esac
done
