#!/usr/bin/bash
##connect to database if it exits and show table menu
source ./tableMenu.sh
connectDB() {
	echo -en "\nEnter DataBase Name that you want connect:  "
	read database
	if [ -d "./dbmsDir/$database" ]
	then
		echo -e "\nConnected to DataBase is Succesful ((^_^)) \n"
		cd ./dbmsDir/$database
		tableMenu
		

	else
		echo -e "\nTheres no DataBase call $database ((X_X))\n"
		source ./menu.sh
	fi
	}
