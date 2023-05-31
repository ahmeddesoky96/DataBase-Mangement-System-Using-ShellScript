#!/usr/bin/bash
##table menu when u connect to DataBase
tableMenu(){
	echo -e "\n-----------------------------------------------------"
	echo "---------------- You R in Table Option --------------"
	echo -e "-----------------------------------------------------\n"
	select choise in "Create Table" "List Table" "Insert Into Table"  "Select From Table" "Delete From Table" "Update Table" "Drop Table" "Exit"
	do 
	case $choise in
	"Create Table") source ../../createTable.sh ;
	tableMenu
	;;
	
	"List Table") 
		echo -e "\n--------------------------------------------------------"
		echo    "|                  Your Table                           |"
		echo -e "--------------------------------------------------------\n"
		if [ "$(ls)" ]  #########3 to check if the file empty
		then
			ls | grep -v Data$ ### ls all table , but we make another file in same dir for table data so we will filter it using grep ^_^;
			echo -e "\n--------------------------------------------------------\n"
			tableMenu
		else
			echo "the directory is empty ";
			echo -e "\n--------------------------------------------------------\n"
			tableMenu
		fi
		;;
	
	"Insert Into Table") source ../../insertNTable.sh ;
	tableMenu
	;;
	
	"Select From Table") source ../../selectTable.sh ;
	tableMenu
	;;
	
	"Delete From Table") source ../../deleteFromTable.sh
	tableMenu
	;;
	
	"Update Table") source ../../updateTable.sh
	tableMenu
	;;
	
	"Drop Table")  source ../../dropTable.sh ;
	tableMenu
	;;
	
	"Exit")  cd ../ ; cd ../ ; source  ./menu.sh
	;;

	*) echo wrong choice;
	   echo Try again;
	   tableMenu
	;;
	
	esac
	done
}

