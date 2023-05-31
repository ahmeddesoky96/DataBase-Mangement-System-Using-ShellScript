#!/usr/bin/bash
############## select from table 
source ../../tableMenu.sh

echo -en "\nEnter Table Name: "
read tableName
#########################	check if table is exit	#####################
if ! [ -f "./$tableName" ] 
then
  	echo -e "\n!!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"
	echo -e "This Table is Not Exist\n"
	echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
	tableMenu
fi
############################################################################

diplayTable(){
	echo -e "\n---------------------------------------------"
	column -t -s '|' -o' | ' $tableName  #### -t for table -s for seprate my column
	echo -e "\n---------------------------------------------"
  }
  
displayColumn(){
	
	echo -e "\nEnter Column Name: \c"
	read colName
	
	fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'") print i}}}' $tableName)
  	if [[ $fid == "" ]]; then
  		echo -e "\n!!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"
  		echo "no table call $colName"
  		displayColumn
  	else 	
  		echo -e "\n---------------------------------------------"
  		awk 'BEGIN{FS="|"}{print $'$fid'}' $tableName
  		echo -e "\n---------------------------------------------"
  	fi


  }
  select choise in "displayTable" "displayColumn" "Exit"
	do 
	case $choise in
	"displayTable")  diplayTable ;
	tableMenu
	;;
	
	"displayColumn")   displayColumn ; 
	tableMenu
	;;
	
	"Exit") exit
	;;

	*) echo wrong choice;
	echo Try again
	;;
	
	esac
	done
