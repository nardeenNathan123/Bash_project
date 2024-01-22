read -p "Enter database you want to list its tables: " connect_db

while [ ! -d "db/$connect_db/" ]
do
echo -e "\e[31mdatabase not found enter the name again\e[0m"
    read connect_db
done

cd db/$connect_db

  

echo -e "\e[34m<<<<<<<<<<<< the tables in this database is >>>>>>>>>>>>>>>>>>>\e[0m"
        for i in db/$connect_db/*;
          do
            
                filename=$(basename "$i")
             if [[ ! "$i" =~ meta* ]];then
                echo $filename   
             fi 

             
             
            
          done
          if [ -z "$(find . -maxdepth 1 -type f -exec echo found \;)" ]; then
            echo -e "\e[31myour database is empty\e[0m"
         fi 
          cd ../..
          source ./minuofTable.sh
