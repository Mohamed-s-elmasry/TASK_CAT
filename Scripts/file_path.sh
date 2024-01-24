# script that takes a file path as input and displays information about the file, such as its size, type, and permissions
#------------------------------------------------------------------------------------------------------------------------

#!/bin/bash 

read -p "Please enter the Path : " path
if [[ ! -z ${path} ]]
then
	cd $path
	echo " the path is correct and you information : "
        ls -l 
else
	echo "please enter a correct and existed path"  
fi


