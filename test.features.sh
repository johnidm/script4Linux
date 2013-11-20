#!/bin/bash  





#Colorir linha
echo "$(tput setaf 1)Hello, world$(tput sgr0)"



Black       0;30     Dark Gray     1;30
Blue        0;34     Light Blue    1;34
Green       0;32     Light Green   1;32
Cyan        0;36     Light Cyan    1;36
Red         0;31     Light Red     1;31
Purple      0;35     Light Purple  1;35
Brown       0;33     Yellow        1;33
Light Gray  0;37     White         1;37

red='\e[0;31m'
NC='\e[0m' # No Color
echo -e "${red}Hello Stackoverflow${NC}"


EXPORT=/usr/bin/data/arquivo.tar.gz.2

file=$(basename $EXPORT)

echo "Arquivo \"$file\""




<<END

FALSE=0
TRUE=1

# escrever em um arquivo, dessa forma sobescreve o aquivo
if [ "$(uname -m)" == "x86_64" ]; then
  echo "64 bit"	
else
  echo "32 bit"
fi

cat <<EOF > teste.txt
--------------------
#!/bin/bash
export TESTE=1
--------------------
EOF
 

# http://www.devin.com.br/mail-via-linha-de-comando/
# http://linuxdicas.wikispaces.com/shell-script


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

END


