#!/usr/bin/bash
## menu 
source ./createDB.sh
source ./connectDB.sh
menu(){
	echo -e "\n\n-------------------------------------------------------"
	echo "|-----------------------------------------------------|"
	echo "|--------------- Main Menu (DB Option) ---------------|"
	echo "|-----------------------------------------------------|"
	echo "-------------------------------------------------------"
	select choise in "Create Database" "List Databases" "Connect to Database" "Drop Database"  "Exit"
	do 
	case $choise in
	"Create Database")  createDB 
	;;
	
	"List Databases")  
	 	echo -e "\n--------------------------------------------------------"
		echo    "|              Your Data Base                          |"
		echo -e "--------------------------------------------------------\n"
		cd ./dbmsDir
	 	if [  "$(ls)" ]  #########3 to check if the file empty
		then
			ls   ### ls all table , but we make another file in same dir for table data so we will filter it using grep ^_^;
			echo -e "\n--------------------------------------------------------\n\n"
		else
			echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		     	echo "Theres No DataBase to List"
		     	echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo -e "\n--------------------------------------------------------\n\n"
		
		fi
		cd ../
		menu
	;;
	
	"Connect to Database") connectDB
	;;
	
	"Drop Database") echo -e "\n\n-----------------------------------------------------"
			echo "------------------ Drop  DataBase ------------------"
			echo "-----------------------------------------------------"
			cd ./dbmsDir
			echo -en "\nEnter DataBase Name u Want Drop: "
			read dataBase
			if [ -d "./$dataBase" ] 
			then
				rm -r  $dataBase 2>>/dev/null
				echo -e "\n--------------------------------------------------------"
				echo    "|              DataBase $dataBase Dropped succesful       |"
				echo -e "--------------------------------------------------------\n\n"
			else
				echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
				echo -e "\n  This DataBase is Not Exist\n"
				echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			fi
			cd ../
			menu
			;;
		
	"Exit") 
	exit
	;;

	*) echo wrong choice;
	echo Try again
	;;
	
	esac
	done
}
menu
