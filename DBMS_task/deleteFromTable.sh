#!/usr/bin/bash
##### delete row from table with condition
source ../../tableMenu.sh
	echo -e "\n\n--------------------------------------------------------"
	echo "------------------ Delete Row From DB ------------------"
	echo "--------------------------------------------------------"
echo -e "\nEnter Table Name: \c"
read tableName
echo -e "\nEnter Condition Column name: \c"
read field
fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
if [[ $fid == "" ]]
then
	echo -e "\n!!!!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!!!"
	echo "Theres No Column Call: $field"
	tableMenu
fi
echo -e "\nEnter Condition Value: \c"
read val
check=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $tableName )
	
if [[ $check == "" ]]
then
	echo -e "\n!!!!!!!!!!!!!!!(X_X)!!!!!!!!!!!!!!!!"
	echo " Value Not Found, Theres No Value = $val "
	tableMenu
fi
awk -F"|" '{if ($'$fid'!="'$val'") {print $0}}' $tableName >> "ahmedtxt"
rm $tableName
cat "ahmedtxt"|tr " " "|" >> $tableName
rm "ahmedtxt"

echo "Deleted Row is Dne (^_^)"
