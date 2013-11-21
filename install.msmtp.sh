#!/bin/bash

# Johni Douglas Marangon
# 11/2013
# Instalação e configuração do msmtp no Ubuntu - http://msmtp.sourceforge.net/


PROGRAMA="msmtp"
CONFIG="/etc/msmtprc"


NO=0
YES=1
FALSE=0
TRUE=1


erro()
{
	echo -e "$(tput setaf 1)${1}$(tput sgr0)"

}


trace()
{
	echo -e "$(tput setaf 3)${1}$(tput sgr0)"
}



informacao() 
{
	whiptail --title "Informação" --msgbox "${1}" 10 78	
}



pergunta() 
{
	whiptail --title "Pergunta" --yesno "${1}" 10 78
	if [ $? = 0 ]; then
		return ${NO}
	else
		return ${YES}
	fi
}


entrada() 
{

    	local _varname=$1 
    	shift

	in=$(whiptail	--title "Informe" \
			--inputbox "$@" \
			10 50 3>&1 1>&2 2>&3)

	if [ $? = 0 ] ; then
		eval "$_varname=\$in"
	fi
}



if [[ $EUID -ne 0 ]]; then
 	informacao "\nEsse script deve ser executado como super usuario.\nTente executar da seguinte maneira - \"sudo ${0}\""
	exit 1
fi


create_file_config()
{

	entrada smtp_account "\nDescricao da conta:\nEx: gmail"
	[ -z $smtp_account ] && trace "[NAO INFORMADO] - Descricao da conta"


	entrada smtp_host "\nServidor de saida de emails (SMTP):\nEx: smtp.gmail.com"
	[ -z $smtp_host ] && trace "[NAO INFORMADO] - Servidor de saida de email (SMTP)"

	entrada smtp_port "\nPorta do servidor de saida de emails (SMTP):\nEx: 587"
	[ -z $smtp_port ] && trace "[NAO INFORMADO] - Porta do servidor de saida de email (SMTP)"

	entrada smtp_from "\nEndereco de email:\nEx: fulano@gmail.com"
	[ -z $smtp_from ] && trace "[NAO INFORMADO] - Endereco de email"

	entrada smtp_user "\nNome do usuario:\nEx: fulano@gmail.com"
	[ -z $smtp_user ] && trace "[NAO INFORMADO] - Nome do usuario"

	entrada smtp_password "\nSenha:"
	[ -z $smtp_password ] && trace "[NAO INFORMADO] - Senha"

	touch ${CONFIG}
	chmod 644 ${CONFIG}

# essa linha nao pode ser identada
cat <<EOF > ${CONFIG}
	#
	# Arquivo de configuração msmtp - http://msmtp.sourceforge.net/
	#


	# Configurações padrão
	defaults
		tls on
		tls_certcheck off
	#	logfile	/vadar/log/msmtprc.log


	# Conta configurada na instalação
	account 	$smtp_account
	host		$smtp_host
	port		$smtp_port
	protocol smtp
	auth login
	from		$smtp_from
	user 		$smtp_user
	password	$smtp_password


	# Conta exemplo
	account someplace
	host smtp.someplace.com
	from someone@someplace.com
	auth login
	user someone
	password somesecret


	account default: $smtp_account

EOF

}



if [[ $EUID -ne 0 ]]; then
 	informacao "\nEsse script deve ser executado como super usuario.\nTente executar da seguinte maneira - \"sudo ${0}\""
	exit 1
fi



if type -p ${PROGRAMA} > /dev/null ; then

	if pergunta "\nO programa ${PROGRAMA} ja esta instalado.\nDeseja reinstalar o programa" -eq YES ; then
		trace "Reinstalando o  programa ${PROGRAMA}"
		apt-get -y purge ${PROGRAMA} && apt-get -y install ${PROGRAMA}
	fi
		
else
	trace "Iniciando a instalacao do ${PROGRAMA}"	
	apt-get -y install ${PROGRAMA}
fi



if [ -f ${CONFIG} ]; then
	if pergunta "\nO arquivo de configuracao ${CONFIG} ja existe.\nDeseja configurar novamente as propriedade do servidor SMTP" ; then
		create_file_config
	fi
else
	echo "arquivo NAO existe"
	create_file_config
fi


[ -z $smtp_from ] && entrada smtp_from "\nInforme um e-mail para teste:\nfulano@gmail.com"

[ -z $smtp_from ] && erro "Email nao informado\nTeste de email nao sera realizado" && exit 1



# Testando o email
trace "Enviando email de teste..."
echo -e "Subject: Teste de instalacao do msmtp\r\n\r\nTeste de instalacao do msmtp" | msmtp -t $smtp_from

if [ $? -eq 0  ] ; then
	trace 	"Instalacao concluida com sucesso\nEmail de teste enviado para \"$smtp_from\""
else
	erro 	"Falha ao enviar email \"$smtp_from\"  \nVerifique as configuracoes de email no arquivo ${CONFIG}"
fi

