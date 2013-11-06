#!/bin/bash

FALSE=0
TRUE=1
: '
exists_directory() {

	# para testar arquivos basta trocar o "d" pelo "f"	
	if [ -d "$1" ]; then
		#echo "Existe"
		return ${TRUE}
	else
		#echo "NAO Existe"
		return ${FALSE}	
	fi
}

if ! exists_directory "/usr/lib/" ; then
	echo "Diretorio existe"
else
	echo "Diretorio NAO existe"
fi
' 

check_program_installed() {
		
	#echo "Comando "${1}
	
	if ! type -p ${1} > /dev/null; then
		#echo "NAO instalado"		
		return ${FALSE}
		#echo "Instalado"			
	fi
	return ${TRUE}
	
}

COMMAND="wget"
if ! check_program_installed "$COMMAND" ; then
	echo $COMMAND" - programa ja instalado"  

else
	echo "Programa NAO instalado"
fi


