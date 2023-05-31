#!/usr/bin/bash

createDB(){
	echo -e "\n\n-----------------------------------------------------"
	echo "------------------ Create DataBase ------------------"
	echo "-----------------------------------------------------"
	echo -en "\nEnter DataBase Name: "
	read dbname
	if [ -d "./dbmsDir/$dbname" ]
	then 
		echo -e "this DataBase is already Exist\n"
		source ./menu.sh
	else
		mkdir ./dbmsDir/$dbname
		echo -e "\n--------------------------------------------------------"
		echo    "|              DataBase  Created succesful             |"
		echo -e "--------------------------------------------------------\n\n"
		source ./menu.sh
	fi
	}

