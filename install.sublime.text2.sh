#!/bin/bash

# Instalacao do Sublime Text
# Johni Douglas Marangon
# 11/2013

APLICACAO="Sublime Text 2.0.2"
PATH_INSTALACAO=


# verifica se o usuario tem permissoes root
if  [ "$(id -u)" != "0" ];  then
  echo "Este script precisa ser executado como root"
  exit  1
fi

# solicita confirmacao da instalacao
read -p "   Deseja realmente instalar o ${APLICACAO}  [s/N] " resp
resp=$(echo "$resp" | tr [[:upper:]] [[:lower:]] | cut -c1)

if [ "$resp" != "s" ]; then
  exit 1	
fi

echo "Iniciando a instalacao do ${APLICACAO}"

# verifica a plataforma para fazer o download
if [ "$(uname -m)" == "x86_64" ]; then
  # 64 bit
  URL=http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2
else
  # 32 bit
  URL=http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.tar.bz2
fi

# download e descompactacao para o diretorio de instalacao
file=$(basename $URL)
wget ${URL} -P /tmp

[ -d "${PATH_INSTALACAO}" ] && rm -rf ${PATH_INSTALACAO}

mkdir -p  ${PATH_INSTALACAO}
chown -R root:root ${PATH_INSTALACAO}
chmod -R +r ${PATH_INSTALACAO}

tar jxvf /tmp/$file ${PATH_INSTALACAO}

# criar o startes

# limpar os diretorios

[ -f /tmp/$file ] && rm /tmp/$file




