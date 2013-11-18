#!/bin/bash

REPOS=$1

if [ -z "${REPOS}" ]; then
	echo "Diretorio nao informado"
	exit 1
fi

if [ -e "${REPOS}" ]; then
	echo "Diretorio ${REPOS} ja existe"
	exit 1
fi

svnadmin create --fs-type fsfs ${REPOS}
if [ $? -ne 0 ]; then
	echo "Falha ao criar o diretoro do SVN"
	exit 1
fi

chown -R www-data:www-data ${REPOS}
if [ $? -ne 0 ]; then
	echo "Falha ao definir permissao para o usuario www-data"
	exit 1
fi

chmod -R 770 ${REPOS}
if [ $? -ne 0 ]; then
	echo "Falha ao definir permissoes de pasta"
	exit 1
fi


echo "${REPOS} repositorio criado com sucesso"

