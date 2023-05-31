#!/usr/bin/bash
#### update Table
source ../../tableMenu.sh
echo -e "\n\n-----------------------------------------------------"
echo "---------------- Update Value In Table --------------"
echo -e "-----------------------------------------------------\n"
echo -en "Enter Table Name: "



  read tableName
  if [ ! -f "./$tableName" ] 
	then
		echo -e "\n     	    ^^^^^^^^^^^^^^^^^^^^^^^^  "
		echo "	  ((		           )) "
		echo "	 ((  	====      ====      )) "
		echo "	 ((	====   	  ====      )) "
		echo "	 ((	     ()	            )) "
		echo "	 ((   -------------------   )) "
		echo "	 ((  (The Table not Exist)  )) "
		echo "	  ((    ---------------	   )) "
		echo "	   ((                     )) "
		echo "       	      vvvvvvvvvvvvvvvvvvv    "
		tableMenu
  fi
  
  fileData=$tableName"Data"
  echo -e "\nEnter Column name That you want change in it : \c"
  read field
  #################################get $.Number column number in our table ##################################
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
  if [[ $fid == "" ]]
  then
  	echo -e "\n!!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"
    	echo -e "| Theres No Column Call: $field |"
    	echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    	tableMenu

  fi
  echo -e "\nEnter Condition Value: \c"
  read val
  echo -e "\nEnter new  Value: \c"
  read newval																			
dataType=$(awk  -F"|" '{if($1=="'$field'") {print $2}}' $fileData)					
pk=$(awk  -F"|" '{if($1=="'$field'") {print $3}}' $fileData)	

	if [[ $pk == "PK" ]]; then

			      	while [[ condition=="true" ]]; do									##############
																	##############
				      	condition=$(awk -v x=$newval  -F"|" '{if ( $'$fid' == x) print  "true" }' $tableName)		##############
				    ###awk -v x=$newval -F"|"  'BEGIN{print $'$fid'}{if ( $'$fid' == x) print  "true" }' $tableName	##############
				      	if [[ ! -z $condition ]]; then									##############
				      		echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
						echo -en " Primary Key Can't be Duplicated ,try Again : "				##############	we check if the valu is there before becuz its pk 
						read newval										##############												
					else												##############	
																	##############
						break;											##############
																	##############
					fi													
				done
			fi
	if [ "$dataType" == "int" ]; then
		
		
		while ! [[ "$newval" = *[0-9] ]]; do
			echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						
			echo -e "\ninvalid DataType Try Again !!"
			echo -en "\nNew Value in $field (hint: Data should be $dataType) : "
			
			read newval
			
			if [[ $pk == "PK" ]]; then

			      	while [[ condition=="true" ]]; do									##############
																	##############
				      	condition=$(awk -v x=$newval  -F"|" '{if ( $'$fid' == x) print  "true" }' $tableName)		##############
				    ###awk -v x=$newval -F"|"  'BEGIN{print $'$fid'}{if ( $'$fid' == x) print  "true" }' $tableName	##############
				      	echo "the condition $condition"									##############		
				      	if [[ ! -z $condition ]]; then									##############
				      		echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
						echo -en " Primary Key Can't be Duplicated ,try Again : "				##############	we check if the valu is there before becuz its pk 
						read newval										##############												
					else												##############	
																	##############
						break;											##############
																	##############
					fi													
				done
			fi
	      	done
	      	
			
	elif [ "$dataType" == "str" ]; then 
		while ! [[ "$newval" = *[a-zA-Z] ]]; do
			echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						
			echo -e "invalid DataType Try Again !!"
			echo -en "\nNew Value in $field (hint: Data should be $dataType) : "
			read newval
			if [[ $pk == "PK" ]]; then
			      	while [[ condition=="true" ]]; do									##############
																	##############	
				      	condition=$(awk -v x=$newval  -F"|" '{if ( $'$fid' == x) print  "true" }' $tableName)	        ##############
				    ###awk -v x=$newval -F"|"  'BEGIN{print $'$fid'}{if ( $'$fid' == x) print  "true" }' $tableName     ##############
				      	echo "the condition $condition"									##############		
				      	if [[ ! -z $condition ]]; then									##############
				      		echo -e "\n!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"						##############
						echo -en "Primary Key Can't be Duplicated ,try Again : "				##############	we check if the valu is there before becuz its pk 
						read newval										##############												
					else												##############	
																	##############
						break;											##############	
																	##############
					fi													
				done
			fi
			
	      	done
		
	fi


#################################check if old value in that column or not in our table ##################################	      	
  check=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $tableName )
	
    if [[ $check == "" ]]
    then
    	echo -e "\n!!!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!"
     	echo "Value Not Found, Theres No Value = $val"
     	echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      	tableMenu
    else
    	
    	awk -v name=$newval -F"|" '{if ($'$fid'=="'$val'"){ $'$fid'=name } {print $0}}' $tableName >> "ahmedtxt"
    	rm $tableName
    	cat "ahmedtxt"|tr " " "|" >> $tableName
    	rm "ahmedtxt"
    	
    	###sed -i "s/$val/drago/g" $tableName
    	echo -e "\n-------------------------------------------------------"
	echo 	"|              Update done succesful      (^_^)        |"
	echo -e "-------------------------------------------------------\n\n"
    fi
    
        	## # awk  'BEGIN{FS="|"}{if ($2=="ahmed") system ("sed 's/"ahmed" /"esca" /g' esca" ) }' esca
