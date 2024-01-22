#!/bin/bash

function insert_data() {
  while true; do
    read -p "Enter database you want to connect with: " connect_db

    if [ -z "$connect_db" ]; then
        echo -e "\e[31mBe careful: \$connect_db is an empty string.\e[0m"
    else
        break  
    fi
  done

  if [ -e "db/$connect_db" ]; then
    while true; do
      read -p "Enter table name: " table_name

      if [ -z "$table_name" ]; then
        echo -e "\e[31mBe careful: \$table_name is an empty string.\e[0m"
      else
        break  
      fi
    done

    if [ -f "db/$connect_db/$table_name" ]; then
      if [ ! -s "db/$connect_db/$table_name" ]; then
          id=1
      else
          last_id=$(tail -n 1 "db/$connect_db/$table_name" | cut -d: -f1)
          ((id = last_id + 1))
      fi

      columns=$(head -n 1 "db/$connect_db/$table_name")
      data_types=$(sed -n '2p' "db/$connect_db/$table_name")

      num_columns=$(echo "$columns" | awk -F: '{print NF}')
      num_data_types=$(echo "$data_types" | awk -F: '{print NF}')

      if [ "$num_columns" -ne "$num_data_types" ]; then
          echo -e "\e[31mBe careful: there is an issue in the file, number of columns and data types do not match.\e[0m"
          source ./table-menu.sh
      fi

      row="$id:"
      for ((i = 2; i <= num_columns; i++)); do
          column_name=$(echo "$columns" | cut -d: -f"$i")
          data_type=$(echo "$data_types" | cut -d: -f"$i")

          if [ "$column_name" != "ID" ]; then
              while true; do
              
                  echo -e "\e[34mEnter $column_name ($data_type): \e[0m"
                  read value

                  case $data_type in
                      "int (Not NULL)")
                          if [[ "$value" =~ ^[0-9]+$ ]] && [[ -n "$value" ]]; then
                              break
                          else
                              echo -e "\e[31mInvalid input. Enter a valid non-empty integer for $column_name.\e[0m"
                          fi
                          ;;
                      "string (Not NULL)")
                          if [[ -n "$value" ]] && ! [[ "$value" =~ [0-9] ]]; then
                              break
                          else
                              echo -e "\e[31mInvalid input. $column_name cannot be empty or contain numbers.\e[0m"
                          fi
                          ;;
                      *)
                          if [ "$data_type" == "string" ]; then
                              if [[ -z "$value" ]] || ! [[ "$value" =~ [0-9] ]]; then
                                  break
                              else
                                  echo -e "\e[31mInvalid input. $column_name can only contain characters or be null.\e[0m"
                              fi
                          elif [ "$data_type" == "int" ]; then
                              if [[ -z "$value" ]] || [[ "$value" =~ ^[0-9]+$ ]]; then
                                  break
                              else
                                  echo -e "\e[31mInvalid input. $column_name can only contain integers or be null.\e[0m"
                              fi
                          else
                              echo -e "\e[31mUnsupported data type: $data_type.\e[0m"
                              echo -e "\e[31mPlease enter the correct value for $column_name.\e[0m"
                              continue
                          fi
                          ;;
                  esac
              done

              row+="$value:"
          else
              row+="$id:"
          fi
      done

      row=$(echo "$row" | sed 's/:$//')

      echo "$row" >> "db/$connect_db/$table_name"
      clear
      echo -e "\e[32m<<<<<<<<<<<< Data inserted successfully with ID: $id. >>>>>>>>>>>>>>\e[0m"
    else
    clear
      echo -e "\e[31m************ Table not found in database $connect_db.***************\e[0m"
    fi
  else 
    clear 
    echo -e "\e[31mDatabase not exist\e[0m"  
    source ./table-menu.sh
  fi
}

insert_data
source ./table-menu.sh

