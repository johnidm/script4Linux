#!/bin/bash

# Script para instalação do emulador para Atari 2600 z26
# www.whimsey.com/z26/
# 
# Johni Douglas Marangon
# 29/10/2013
# http://www.johnidouglas.com.br/


# Mais informacoes http://www.whimsey.com/z26/z26.pdf

echo "Instalando z26 Atari 2600 Emulador"

File=z26v3.02.01s.zip
URL=http://www.whimsey.com/z26/${File}
DirInstalation=/usr/lib/z26
DirTemp=/tmp
Starter=z26.desktop

TRUE=1
FALSE=0

WGET="wget"
UNZIP="unzip"
MAKE="make"

# funcoes 
program_installed() {		
	if ! type -p ${1} > /dev/null; then		
		return ${FALSE}
	fi
	return ${TRUE}	
}

clean_up() {
	[ -f ${DirTemp}/${File} ] && rm ${DirTemp}/${File}
	[ -d ${DirTemp}/z26 ] && rm -R ${DirTemp}/z26
}

# verifica permissao de root
if [[ $EUID -ne 0 ]]; then
	echo "ERRO - script nao tem permissao para ser executado - tente da seguinte maneira \"sudo ${0}\" "
	exit 1
fi

# atualizacoes
: '
apt-get update
apt-get install build-essential
'
# validacaoes
if program_installed ${WGET} ; then
	echo ${WGET}" nao instalado" 	
	exit 1
fi
if program_installed ${UNZIP} ; then
	echo ${UNZIP}" nao instalado" 	
	exit 1
fi  
if program_installed ${MAKE} ; then
	echo ${MAKE}" nao instalado" 	
	exit 1
fi

clean_up


${WGET} -N ${URL}  -P ${DirTemp}

${UNZIP} -o ${DirTemp}/${File} -d ${DirTemp}/z26

${MAKE} linux -C ${DirTemp}/z26/src


[ -d ${DirInstalation} ] && rm -rf ${DirInstalation}


mkdir -p ${DirInstalation}

chown -R root:root ${DirInstalation}
chmod -R +r ${DirInstalation}

mv ${DirTemp}/z26/src/z26 ${DirInstalation}
mv ${DirTemp}/z26/src/z26.ico ${DirInstalation}


cat <<EOF>> ${DirTemp}/z26/${Starter}
[Desktop Entry]
Encoding=UTF-8
Name=z26 Atari 2600 Emulator
Comment=z26 Atari 2600 Emulator
Exec=${DirInstalation}/z26
Icon=${DirInstalation}/z26.ico
Terminal=false
Type=Application
Categories=GNOME;Application;Game
StartupNotify=true
EOF

mv ${DirTemp}/z26/z26.desktop /usr/share/applications/${Starter}
chmod +r /usr/share/applications/${Starter}

clean_up

echo "Instalacao concluida com sucesso"











