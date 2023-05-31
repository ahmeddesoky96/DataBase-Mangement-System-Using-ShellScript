#!/usr/bin/bash
####### we will just drop table using remove file for main table file and its dataFile
source ../../tableMenu.sh
echo -e "\n\n-----------------------------------------------------"
	echo "------------------ Drop  Table ------------------"
	echo "-----------------------------------------------------"
echo -en "\nEnter Table Name u Want Drop: "
read tableName
if [ -f "./$tableName" ] 
then
	rm $tableName $tableName"Data" 2>>/dev/null
	echo -e "\n--------------------------------------------------------"
	echo    "|          Tabel $tableName Dropped succesful    (^_^)   |"
	echo -e "--------------------------------------------------------\n\n"
	tableMenu
else
	echo -e "\n!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!!"
	echo -e "  This Table is Not Exist"
	echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

	tableMenu
fi
