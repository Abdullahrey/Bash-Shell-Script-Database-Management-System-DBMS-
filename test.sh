#!/bin/bash
echo "This script created by Abdullah Mohamed & Hazem Mostafa"


if [[ -d ./databases ]]
then
	echo "Databases exists on your filesystem."
else
	mkdir databases
	echo "Databases created successfully."
fi

function main {
	echo "-------------------------------------------"
	echo " Press 1 to create database "
	echo " Press 2 to list databases "
	echo " Press 3 to connect to databases "
	echo " Press 4 to drop database "
	echo " Press 5 to Exit "
	echo "-------------------------------------------"
	read choice

	case $choice in
		1) create_db
			;;
		2) list_db
			;;
		3) connect_db
			;;
		4) drop_db
			;;
		5)	echo " Thanks for using this script "
			exit ;;
		*) 	echo " Please choose valid option "
			echo "------------------------------------------"

			main ;;
	esac
}
##########################################
##### call from main #####################
function connect_db {
	echo " Enter database name ";
	read db_name;
        if [[ -d ./databases/$db_name ]]
        then
		cd ./databases/$db_name;
		echo "-------------------------------------------"
                echo "connected successfully to database $db_name"

		main_table;
        else
		echo "-------------------------------------------"
                echo "$db_name is not exists, please enter valid database name or create new database"
		echo "-------------------------------------------"
        fi

	main;
}
##########################
function main_table {
	echo "--------------------------------------------------------------------------";
	echo " Press 1 to create table "
        echo " Press 2 to list tables "
        echo " Press 3 to drop any table "
        echo " Press 4 to insert into any table "
        echo " Press 5 to select all row from any table "
	echo " Press 6 to delete all row from any table "
	echo " Press 7 to disconnect from this database "
	echo "--------------------------------------------------------------------------";
        read choice
        case $choice in
                1) create_table
                        ;;
                2) list_tables
                        ;;
                3) drop_table
                        ;;
                4) insert_into_table
                        ;;
                5) select_from_table
			;;
		6) delete_from_table
			;;
		7) disconnect_db
			;;
                *) 
			echo "--------------------------------------------------------------------------";
			echo " Please enter right choice ";
			echo "--------------------------------------------------------------------------";
                        main_table ;;
        esac

}
##########################################
##### call from main_table ###############
function create_table {
	echo "--------------------------------------------------------------------------";
	echo "Enter table name";
	echo "--------------------------------------------------------------------------";

	read table_name;
	if [[ -d ./$table_name ]]
        then
		echo "--------------------------------------------------------------------------";               
                echo "Please enter valid table name";
		echo "--------------------------------------------------------------------------";
        else
		mkdir $table_name
                touch ./$table_name/metadata.csv
		touch ./$table_name/values.csv
                chmod 777 ./$table_name/metadata.csv
		chmod 777 ./$table_name/values.csv
		echo "--------------------------------------------------------------------------";
                echo "Enter number of column";
		echo "--------------------------------------------------------------------------";
		read col_num
		while [ $col_num -gt 0 ]
		do
			echo "--------------------------------------------------------------------------";
			echo "Enter column Name";
			echo "--------------------------------------------------------------------------";
                        read col_name;
                        echo "Please enter column type";
			echo "--------------------------------------------------------------------------";
			echo "Press 1 if int";
			echo "Press 2 if string";
			echo "Press 3 if boolean";
			echo "--------------------------------------------------------------------------";
                        read choice
                        case $choice in
				1) echo  "$col_name,int" >> ./$table_name/metadata.csv;
					;;
                                2) echo  "$col_name,string" >> ./$table_name/metadata.csv;
					;;
                                3) echo  "$col_name,bool" >> ./$table_name/metadata.csv;
                                        ;;
                                *) 
					echo "--------------------------------------------------------------------------";
					echo "please enter valid choice";
					echo "--------------------------------------------------------------------------";
					;;
			esac
			col_num=$(( $col_num - 1 ))
			echo "$col_num";
		done
		echo "--------------------------------------------------------------------------";
                echo "Table $table_name created successfully";
		echo "--------------------------------------------------------------------------";
	fi
	main_table;
}
##########################################
##### call from main_table ###############
function list_tables {
	echo "Tables list";
	echo "--------------------------------------------------------------------------";
	ls;
	echo "--------------------------------------------------------------------------";
	main_table;
}
##########################################
##### call from main_table ###############
function drop_table {
	echo "--------------------------------------------------------------------------";
	echo "Enter table name ";
	echo "--------------------------------------------------------------------------";
	read table_name;
	if [[ -d ./$table_name ]]
        then
                rm -r ./$table_name ;
		echo "--------------------------------------------------------------------------";
                echo " Table $table_name dropped successfully.";
		echo "--------------------------------------------------------------------------";
        else
		echo "------------------------------------------------------------------------------";
                echo " Table $table_name not exists on your tables, please try again with valid table name";
		echo "------------------------------------------------------------------------------";

        fi
	main_table;
}
##########################################
##### call from main_table ###############
function insert_into_table {
	echo "Enter table name ";
	read table_name;
	if [[ -d ./$table_name ]]
        then
		echo "--------------------------------------------------------------------------";
		echo "Enter values ";
		echo "--------------------------------------------------------------------------";
                IFS=',';
                recoredsfile="metadata.csv"
                columns_name=`awk 'BEGIN{FS=","; OFS="|";ORS = ","} {print $1,$2 }' ./$table_name/$recoredsfile`
		for col in $columns_name
		do
			echo "Enter $col"
                        read input
		        new_row="$new_row,$input";
			echo "$new_row" >>  ./$table_name/"values.csv"
			new_row="";


		done
		#echo "$new_row" >>  ./$table_name/"values.csv"

	else
		echo "--------------------------------------------------------------------------";
		echo "Please enter valid table name";
		echo "--------------------------------------------------------------------------";
	fi
	main_table;
}
##########################################
##### call from main_table ###############
function select_from_table {
	echo "--------------------------------------------------------------------------";
	echo "Enter table name";
	echo "--------------------------------------------------------------------------";
	read table_name;
	if [[ -d ./$table_name ]]
        then
		echo "--------------------------------------------------------------------------";
		awk 'BEGIN{FS=","; OFS="|";ORS = "\n"} {print $0}' ./$table_name/values.csv;
		echo "--------------------------------------------------------------------------";



        else
		echo "--------------------------------------------------------------------------";
                echo "Please enter valid table name";
		echo "--------------------------------------------------------------------------";

        fi
	main_table;

}
##########################################
##### call from main_table ###############
function delete_from_table {
	echo "--------------------------------------------------------------------------";
        echo "Enter table name";
	echo "--------------------------------------------------------------------------";
        read table_name;
        if [[ -d ./$table_name ]]
        then
               echo -n "" > ./$table_name/values.csv

        else
		echo "--------------------------------------------------------------------------";
                echo "Please enter valid table name";
		echo "--------------------------------------------------------------------------";

        fi

	main_table;

}
#############################################
### call from main_table ### back to main ###
function disconnect_db {
	cd .. ; 
	cd .. ;
	echo "--------------------------------------------------------------------------";
	echo "Disconnected successfully";
	echo "--------------------------------------------------------------------------";

	main;
}
##########################################
##### call from main #####################
function list_db {
	echo "List of databases";
	echo "--------------------------------------------------------------------------";
	ls ./databases
	echo "--------------------------------------------------------------------------";
	main;
}

##########################################
##### call from main #####################
function create_db {
	echo "--------------------------------------------------------------------------";
	echo " Enter database name ";
	echo "--------------------------------------------------------------------------";

	read db_name;
	if [[ -d ./databases/$db_name ]]
	then
		echo "-----------------------------------------------------------------------------";
		echo "$db_name exists on  databases, please try again with valid database name.";
		echo "-----------------------------------------------------------------------------";

	else
		mkdir ./databases/$db_name
		echo "--------------------------------------------------------------------------";
		echo " Database $db_name created successfully ";
		echo "--------------------------------------------------------------------------";

	fi
	main;
}

########################################
##### call from main #####################
function drop_db {
	echo "--------------------------------------------------------------------------";
	echo " Enter database name ";
	echo "--------------------------------------------------------------------------";
	read db_name ;
	if [[ -d ./databases/$db_name ]]
        then
		rm -r ./databases/$db_name ;
		echo "--------------------------------------------------------------------------";
                echo "$db_name dropped successfully.";
		echo "--------------------------------------------------------------------------";

        else
		echo "--------------------------------------------------------------------------";
                echo " $db_name not exists on databases, please try again with valid databse name";
		echo "--------------------------------------------------------------------------";

        fi
	main;
}

main

