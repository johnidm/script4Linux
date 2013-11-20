#!/bin/bash

# Backup de repositorios SVN
# Johni Douglas Marangon
# 11/2013

# Funcionalidades
#  - backup local; feito em um diretorio configurado na pr�pria maquina 
#  - backup remoto; feito em um local que n�o � a m�quina, ex: CD-ROM; HD externos; pen drives  
#  - exclus�o de diret�rios antigos de backup
#  - notifica��o por e-mail do estado do backup

# Configura��o
#  - Configurar o repositorio do SVN - "REPOS_SVN" 
#  - Configurar o diret�rio de bakcup - "DIR_BACKUP"
#  - Quantidade de dias de aramzenamento de backup - "DIAS_LIMITE_BACKUP" 	
#	Se a quantidade de dias configurada for "0" a exclus�o n�o sera realizada
#	Os logs n�o s�o exclu�dos
#	Ex: se configurado com valor 30, os backups feitos com Dia - 30 ser�o exclu�dos; 
#		

# Instala��o
#  - Uma sugest�o � criar um diretorio na raiz de instala��o do SVN e colocar o script de backup nesse local.
#  - Nao se esqueca de dar as devidas permissoes de execucao desse arquivo: "sudo chmod +x backup_svn.sh"		 
#  - Utilize o crontab para agendar a execu�ao desse script
#   	Ex: para agendar o bakcup de segunda a sexta as 12:30 inclui esse linha no arquivo /etc/crontab > "30 12 * * 1-5 root sh /var/svn/conf/backup_svn.sh"


REPOS_SVN=/var/svn/repos
DIR_BACKUP=/home/msys/svn/backup
DIAS_LIMITE_BACKUP=0


# nomenclatura do diret�rio de backup com todos os dumps dos reposit�rios SVN
DIR_BACKUP_DUMP=${DIR_BACKUP}/dump/$(date +%Y-%m-%d-%H-%M-%S)

# Nome do arquivo de log com o status dos backups
DIR_BACKUP_LOG=${DIR_BACKUP}/log/$(date +%Y-%m-%d-%H-%M-%S).log


FALHA=0 # false


# exclui backup antigos feito localmente

: '
excluir_backup_antigos() {

	if [ ${DIAS_LIMITE_BACKUP} -eq "0" ]; then
		log "Exclus�o de backups antigos est� desabilitada"
	else		
		
		_dir=DIR_BACKUP_DUMP/		
		rm -rf ${_dir}
		[ [ $? -eq 0 ] ] && log "Arquivos de backup do diret�rio ${_dir} exclu�dos com sucesso"		
	fi	
}
'

# registra as etapas do backup 
log() {  

  	[[ ! -d ${DIR_BACKUP_LOG} ]] && mkdir -p $(dirname ${DIR_BACKUP_LOG})
  	if [[ ! -f ${DIR_BACKUP_LOG} ]]; then
    		touch ${DIR_BACKUP_LOG} 
    		chmod 777 ${DIR_BACKUP_LOG} 
  	fi

  	_linha="$(date +%d/%m/%Y-%H:%M:%S) $1"
 
  	echo $_linha >> ${DIR_BACKUP_LOG}  

}

#### - inicio fluxo

log "Iniciando backup"

log "Criando diretorio de backup ${DIR_BACKUP_DUMP}"
if [[ ! -d ${DIR_BACKUP_DUMP} ]]; then
  	mkdir -p ${DIR_BACKUP_DUMP}
fi


log "Iniciando dump dos repositorios"
cd ${REPOS_SVN}
for _repo in *; do
  	
	# backup local
  	svnadmin dump ${_repo} > ${DIR_BACKUP_DUMP}/${_repo}.dump
  	if [ $? -eq 0 ]; then
    		_retorno="- [OK] -  ${_repo}"
  	else
    		_retorno="- [FALHA] -  ${_repo}"
    		[ ${FALHA} -eq 0 ] && FALHA=1        
 	fi
	log "${_retorno}"
  
	# backup remoto
	# nesse local pode ser feito outros tipos de backup como por exemplo: CD-ROM; HD externos; pen drives
	
done 
log "Finalizando dump dos repositorios"

#excluir_backup_antigos

log "Finalizando backup"



# envo de e-mail para notifica��es
# pode ser utilizado qualquer programa de envio de e-mail
# nesse exemplo estou utilizando o msmtp - http://msmtp.sourceforge.net/
_log=$(<${DIR_BACKUP_LOG})
echo "$_log"

# envio do email com notifica��o do estado no backup no t�tulo	
# substituir a tag <email> pelos e-mails que ser�o notificados: 
# ex: gerente@empresa.com.br, suporte@empresa.com.br,denvolvimento@empresa.com.br
		
cat <<EOF | msmtp -a gmail -t #<email>#
	Subject: Backup de repositorios SVN $( [ $FALHA -eq 1 ] && echo " - FALHA" )
	Resultado
	$_log
EOF


#### - fim fluxo
