read -p "Enter database you want to connect with: " connect_db

while [ ! -d "db/$connect_db/" ]
do
    echo -e "\e[31mdatabase not found \e[0m"
    read -p "Enter correct name of database you want to connect with: " connect_db
done

read -p "Enter table name : " table_name

while [ ! -f "db/$connect_db/$table_name" ]
do
    echo -e "\e[31mtable not found \e[0m"
    read -p "Enter correct table name you want to delete: " table_name
done

        if [[ -f db/$connect_db/$table_name ]];then
            rm db/$connect_db/$table_name
            clear
            echo -e "\e[32m*********** table deleted **************\e[0m"
            source minuofTable.sh
            else 
             echo -e "\e[32m************ table not found ************\e[0m"
             source ./minuofTable.sh
            fi 
