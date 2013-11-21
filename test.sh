#!/bin/bash


#declare globalvar='some string'

#result="/tmp/output"
#whiptail --inputbox "Please enter you name ..." 10 50 2>$result
#echo "Ok, your name is $(cat $result)"






#whiptail --backtitle "A Simple User Interface" --inputbox "User Name:" 10 20 2>$user_name



#saida="sample"
#texto=$(whiptail  --inputbox "Username:" 8 50)
#echo $texto


#map=$(whiptail --title "Extract and merge ac3 only" --inputbox "What is the map number of the the audio?" 8 78 3>&1 1>&2 2>&3)

#echo $map



function mylist()
{
    local _varname=$1 
    shift
	
#    for _p in "$@"; do
	echo $@ 
 #       _t=$_t[$_p]
 #   done	

    eval "$_varname=\$_t"
}

mylist tmpvar "Teste"
echo "result: $tmpvar"





#string ()
#{
#  eval  "$1='some other string'"
#} # ----------  end of function string  ----------

#string globalvar

#echo "'${globalvar}'"
