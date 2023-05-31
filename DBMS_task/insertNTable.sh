#!/usr/bin/bash
## Insert data in table and check data entered with file TableData
source ../../tableMenu.sh

echo -en "\nEnter Table Name :  "
read tableName
#########################	check if table is exit	#####################
if ! [ -f "./$tableName" ] 
then
	echo -e "\n!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
	echo -e "This Table is Not Exist"
	echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"						##############
	tableMenu
fi
############################################################################
fileData=$tableName"Data"
##insertRow="" ############### varibale to store our data row
colNumber=$( wc -l < $fileData ) ## get the number of columns from fileData and using < to throw the file name 

####################################################  read Data from user  ###############################################################
for (( i=3 ; i<=colNumber ; i++ ))
do 

########get column name,type if its pk or not  in Number of record mean line ###########################
	colName=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' $fileData)	
	colType=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $2}' $fileData)
	colPK=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $3}' $fileData)
#########################################################################################################
#################################get $.Number column number in our table ##################################
 fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'") print i}}}' $tableName)
#########################################################################################################
	echo -en "\nEnter Data in $colName (hint: Data should be $colType) : "
	read insertData
	
########check the insert data if it match with type in fileData	####################
			if [[ $colPK == "PK" ]]; then
			      	while [[ condition=="true" ]]; do									##############
																	##############		
				      	condition=$(awk -v x=$insertData  -F"|" '{if ( $'$fid' == x) print  "true" }' $tableName)	##############
				    ###awk -v x=$insertData -F"|"  'BEGIN{print $'$fid'}{if ( $'$fid' == x) print  "true" }' $tableName	##############
				      	if [[ ! -z $condition ]]; then									##############	
				      		echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
						echo -en "\ninvalid input for Primary Key try Again : "					##############	we check if the valu is there before becuz its pk 
						read insertData										##############												
					else												##############
																	##############
						break;											##############
																	##############
					fi													
				done
			fi
	if [ "$colType" == "int" ]; then
		
		while ! [[ "$insertData" = *[0-9] ]]; do
			echo -e "\ninvalid DataType Try Again !!"
			echo -en "\nEnter Data in $colName (hint: Data should be $colType) : "
			
			read insertData
			
			if [[ $colPK == "PK" ]]; then
			      	while [[ condition=="true" ]]; do									##############
																	##############
				      	condition=$(awk -v x=$insertData  -F"|" '{if ( $'$fid' == x) print  "true" }' $tableName)	##############
				    ###awk -v x=$insertData -F"|"  'BEGIN{print $'$fid'}{if ( $'$fid' == x) print  "true" }' $tableName	##############
				      	if [[ ! -z $condition ]]; then									##############
				      		echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
						echo -en "\ninvalid input for Primary Key try Again : "					##############	we check if the valu is there before becuz its pk 
						read insertData										##############												
					else												##############	
																	##############
						break;											##############
																	##############
					fi													
				done
			fi
	      	done
	      	
			
	elif [ "$colType" == "str" ]; then 
		while ! [[ "$insertData" = *[a-zA-Z] ]]; do
			echo -e "\ninvalid DataType Try Again !!"
			echo -en "\nEnter Data in $colName (hint: Data should be $colType) : "
			read insertData
			if [[ $colPK == "PK" ]]; then
			      	while [[ condition=="true" ]]; do									##############
																	##############	
				      	condition=$(awk -v x=$insertData  -F"|" '{if ( $'$fid' == x) print  "true" }' $tableName)	##############
				    ###awk -v x=$insertData -F"|"  'BEGIN{print $'$fid'}{if ( $'$fid' == x) print  "true" }' $tableName ##############
				      	if [[ ! -z $condition ]]; then									##############
				      		echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
						echo -en "\ninvalid input for Primary Key try Again : "					##############	we check if the valu is there before becuz its pk 
						read insertData										##############												
					else												##############	
																	##############
						break;											##############	
																	##############
					fi													
				done
			fi
			
	      	done
		
	fi
	
####################################################################################
	if [[ $i == $colsNum ]]; then
      		insertRow=$insertRow$insertData"\n";
    	else
      		insertRow=$insertRow$insertData"|";
    	fi
    	echo -e "\n(^_^)"
    	
done
echo -e $insertRow >> $tableName
echo -e "\n--------------------------------------------------------"
echo    "|                   Insert Complity                    |"
echo -e "--------------------------------------------------------\n\n"

insertRow=""
tableMenu

