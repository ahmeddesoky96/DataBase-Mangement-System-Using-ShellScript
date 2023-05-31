#!/usr/bin/bash
### create table with number of column and take it type which is string or int 
source ../../tableMenu.sh
echo "-----------------------------------------------------"
echo "------------------- Create Table --------------------"
echo "-----------------------------------------------------"
echo -en "\nEnter Table Name u Want Create: "
read tableName
if [ -f "./$tableName" ] 
then
	echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     	echo 	"  This Table is Already Exist  "
     	echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"

	tableMenu
fi
##########touch $tableName

echo -en "\nEnter Number of column: "
read colNumber
declare -i counter=1
addressData="colName|colType|PK"
fileData=$tableName"Data"
##########touch $fileData 
echo $addressData >> $fileData
columnData=""
colInsert="" # we used colInsert to insert column name in table 
PK=""
touch "tempFile"
##loop to set column
while [ $counter -le $colNumber ]
do 
	echo -en "\nenter $counter th column name: "
	read colName
#####################################check if input not duplicate ###################	
				while [[ condition=="true" ]]; do									##############
																	##############		
				      	fid=$(awk  -F"|" '{if($1=="'$colName'") {print $0}}' "tempFile")				##############
				      	if [[ ! -z $fid ]]; then									##############		
						echo -en "invalid input, theres Column had same name, try Again : "			##############	we check if column not duplicate  
						read colName										##############												
					else												##############
																	##############
						break;											##############
																	##############
					fi													
				done
	###fid=$(awk  -F"|" '{if($1=="'$colName'") {print $0}}' $fileData)
 	###echo "number of colmun $fid"
	echo -e "\nenter $colName column DataType: "
	select dataType in "int" "str"
	    do
	      case $dataType in
		int ) colType="int";break;;
		str ) colType="str";break;;
		* ) echo "Wrong Choice" ;;
	      esac
	    done
	if [[ $PK == "" ]]; then
	      echo -e "\nMake PrimaryKey ? "
	      select choise in "yes" "no"
	      do
		case $choise in
		  yes ) PK="PK";
		  columnData+="\n"$colName"|"$dataType"|"$PK; ## set column if we will make this premary key 
		  break;;
		  no )
		  columnData+="\n"$colName"|"$dataType"|";    ## set column if we won't make this premary key
		  break;;
		  * ) echo "Wrong Choice" ;;
		esac
	      done
	else
	      columnData+="\n"$colName"|"$dataType"|";
	fi
	if [[ $counter == $colsNum ]]; then
	      colInsert=$colInsert$colName
	    else
	      colInsert=$colInsert$colName"|"
	    fi
	
	counter+=1
	echo -e $columnData  >> "tempFile"
done
rm "tempFile"
echo -e	$columnData  >> $fileData ## inerst column data into another file to use it check when i insert data in table
echo -e $colInsert >> $tableName ## just draw table with it column 
echo -e "\n-----------------------------------------------------"
echo "|              Table  Created succesful             |"
echo -e "-----------------------------------------------------\n\n"

tableMenu

