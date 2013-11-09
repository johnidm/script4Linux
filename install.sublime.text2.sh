#!/bin/bash

# Instalacao do Sublime Text
# Johni Douglas Marangon
# 11/2013

APLICACAO="Sublime Text 2.0.2"
PATH_INSTALACAO=/usr/lib
DIR_INSTALACAO=SublimeText2

# verifica se o usuario tem permissoes root
if  [ "$(id -u)" != "0" ];  then
  echo "Este script precisa ser executado como root"
  exit  1
fi

# solicita confirmacao da instalacao
read -p "Deseja realmente instalar o ${APLICACAO}  [s/N] " resp
resp=$(echo "$resp" | tr [[:upper:]] [[:lower:]] | cut -c1)

if [ "$resp" != "s" ]; then
  exit 1	
fi

echo "Iniciando a instalacao do ${APLICACAO}"

# verifica a plataforma para fazer o download

if [ "$(uname -m)" == "x86_64" ]; then
  # 64 bit	
  URL=http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2
  FILE_TMP=Sublime\ Text\ 2.0.2x64.tar.bz2	
else
  # 32 bit
  URL="http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.tar.bz2" 
  FILE_TMP=Sublime\ Text\ 2.0.2.tar.bz2	
fi

FILE=SublimeText2.tar.bz2

if [[ ! -f /tmp/$FILE_TMP ]]; then
  wget ${URL} -P /tmp  
fi
	

if [ "$(uname -m)" == "x86_64" ]; then
  # 64 bit	
  mv /tmp/Sublime\ Text\ 2.0.2x64.tar.bz2 /tmp/$FILE	
else
  # 32 bit
  mv /tmp/Sublime\ Text\ 2.0.2.tar.bz2 /tmp/$FILE
fi

tar jxvf /tmp/$FILE -C /tmp
mv /tmp/Sublime\ Text\ 2 /tmp/${DIR_INSTALACAO}

[ -d "${PATH_INSTALACAO}/${DIR_INSTALACAO}" ] && rm -rf ${PATH_INSTALACAO}/${DIR_INSTALACAO}

mkdir -p  ${PATH_INSTALACAO}/${DIR_INSTALACAO}
chown -R root:root ${PATH_INSTALACAO}/${DIR_INSTALACAO}
chmod -R +r ${PATH_INSTALACAO}/${DIR_INSTALACAO}

mv /tmp/${DIR_INSTALACAO} $PATH_INSTALACAO

[[ ! -h /usr/bin/sublime ]] && ln -s /${PATH_INSTALACAO}/${DIR_INSTALACAO}/sublime_text /usr/bin/sublime

Starter=/usr/share/applications/sublime.desktop

cat <<EOF>> ${Starter}
[Desktop Entry]
Version=1.0
Name=Sublime Text 2
GenericName=Text Editor
 
Exec=sublime
Terminal=false
Icon=${PATH_INSTALACAO}/${DIR_INSTALACAO}/Icon/48x48/sublime_text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow
 
[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
EOF
 
chmod +r ${Starter}


[[ -f /tmp/$FILE ]] && rm /tmp/$FILE




