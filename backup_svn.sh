#!/bin/bash

# Backup de repositorios SVN e envio de email com msmtp - http://msmtp.sourceforge.net/
# Johni Douglas Marangon
# 11/2013

# Dicas
# Criar um diretorio conf na raiz do SVN e coloque esse arquivo la junto com os demais arquivos de configuracao do SVN
# Utilize o crontab para agendar a execuçao desse script
# Nao se esqueca de dar as devidas permissoes de execucao desse arquivo -> sudo chmod +x backup_svn.sh
#

REPOS_SVN=/var/svn/repos
DIR_BACKUP=/home/msys/svn/backup/dump/$(date +%Y-%m-%d-%H-%M-%S)
DIR_LOG=/home/msys/svn/backup/log/$(date +%Y-%m-%d-%H-%M-%S).log


log() {  
  [[ ! -d ${DIR_LOG} ]] && mkdir -p $(dirname ${DIR_LOG})
  if [[ ! -f ${DIR_LOG} ]]; then
    touch ${DIR_LOG} 
    chmod 777 ${DIR_LOG} 
  fi

  linha="$(date +%d/%m/%Y-%H:%M:%S) $1"
 
  echo $linha >> ${DIR_LOG}  
  #echo $linha
}


log "Iniciando backup"


log "Criando diretorio de backup ${DIR_BACKUP}"
if [[ ! -d ${DIR_BACKUP} ]]; then
  mkdir -p ${DIR_BACKUP}
fi

FALHA=0 #false

log "Iniciando dump dos repositorios"
cd ${REPOS_SVN}
for repo in *; do
  
  svnadmin dump ${repo} > ${DIR_BACKUP}/${repo}.dump
  if [ $? -eq 0 ]; then
    retorno="- [OK] -  ${repo}"
  else
    retorno="- [FALHA] -  ${repo}"
    [ ${FALHA} -eq 0 ] && FALHA=1        
  fi
  log "${retorno}"
  
  # copiar os arquivos para o diretorio remoto
  
   
done 
log "Finalizando dump dos repositorios"

log "Finalizando backup"

texto=$(<${DIR_LOG})
echo "$texto"


# envia email indicando o estado do backup
cat <<EOF | msmtp -a microsys -t <enderecos de email>
Subject: Backup de repositorios SVN $( [ $FALHA -eq 1 ] && echo " - FALHA" )

Resultado:

$texto

EOF