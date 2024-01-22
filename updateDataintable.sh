#!/bin/bash

function update_data() {
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

    if [ -f "db/$connect_db/$table_name" ]; then
        if [ ! -s "db/$connect_db/$table_name" ]; then
            echo -e "\e[31mTable is empty. No data to update.\e[0m"
        else
            columns=$(head -n 1 "db/$connect_db/$table_name")
            data_types=$(sed -n '2p' "db/$connect_db/$table_name")

            num_columns=$(echo "$columns" | awk -F: '{print NF}')
            num_data_types=$(echo "$data_types" | awk -F: '{print NF}')

            if [ "$num_columns" -ne "$num_data_types" ]; then
                echo -e"\e[31mError: Number of columns and data types do not match.\e[0m"
            else
                read -p "Enter the ID of the record you want to update: " update_id

                if grep -q "^$update_id:" "db/$connect_db/$table_name"; then
                    row_to_update=$(grep "^$update_id:" "db/$connect_db/$table_name")

                    existing_values=$(echo "$row_to_update" | cut -d: -f2-)

                    echo -e "\e[34mCurrent values for the record with ID $update_id: $existing_values\e[0m"

                    updated_row="$update_id:"
                    for ((i = 2; i <= num_columns; i++)); do
                        column_name=$(echo "$columns" | cut -d: -f"$i")
                        data_type=$(echo "$data_types" | cut -d: -f"$i")

                        if [ "$column_name" != "ID" ]; then
                            while true; do
                                read -p "Enter the new correct value for $column_name ($data_type): " updated_value

                                case $data_type in
                                    "int (Not NULL)")
                                        if [[ "$updated_value" =~ ^[0-9]+$ ]] && [[ -n "$updated_value" ]]; then
                                        clear
                                            break
                                        else
                                            echo -e "\e[31mInvalid input. Enter a valid non-empty integer for $column_name.\e[0m"
                                        fi
                                        ;;
                                    "string (Not NULL)")
                                        if [[ -n "$updated_value" ]] && ! [[ "$updated_value" =~ [0-9] ]]; then
                                        clear
                                            break
                                        else
                                            echo -e "\e[31mInvalid input. $column_name cannot be empty or contain numbers.\e[0m"
                                        fi
                                        ;;
                                    "string")  
                                        if [[ -z "$updated_value" ]] || ! [[ "$updated_value" =~ [0-9] ]]; then
                                        clear
                                            break
                                        else
                                            echo -e "\e[31mInvalid input. $column_name can only contain characters or be null.\e[0m"
                                        fi
                                        ;;
                                    "int")  
                                        if [[ -z "$updated_value" ]] || [[ "$updated_value" =~ ^[0-9]+$ ]]; then
                                        clear
                                            break
                                        else
                                            echo -e "\e[31mInvalid input. $column_name can only contain integers or be null.\e[0m"
                                        fi
                                        ;;
                                    *)
                                        echo -e "\e[31mUnsupported data type: $data_type.\e[0m"
                                        echo -e "\e[31mPlease enter the correct value for $column_name.\e[0m"
                                        continue
                                        ;;
                                esac
                            done

                            updated_row+="$updated_value:"
                        else
                            updated_row+="$update_id:"
                        fi
                    done

                    updated_row=$(echo "$updated_row" | sed 's/:$//')

                    sed -i "s/^$update_id:.*/$updated_row/" "db/$connect_db/$table_name"
                    echo -e "\e[32mRecord with ID $update_id updated successfully.\e[0m"

                else
                    echo -e "\e[31mRecord with ID $update_id not found in the table.\e[0m"
                fi
            fi
        fi
    else
        echo -e "\e[31mTable not found in database $connect_db.\e[0m"
    fi
}

update_data
source ./table-menu.sh

