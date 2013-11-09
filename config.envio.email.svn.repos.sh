#installar o sendeemail

#http://www.vivaolinux.com.br/script/Envio-de-email-via-console
#http://www.vivaolinux.com.br/artigo/Enviando-emails-pelo-terminal/?pagina=1


# verificar se o programa ja esta instalado 
apt-get install sendemail


# cria o script para envio de email com a mensagem do e-mail
# Le um arquivo com a lsita de e-mail para enviar 
# montar o corpo do email
# envia utilizando o sendEmail

# criar o hook para envio de e-mail nos post commit


# criar um arquivo de configuracao que ira ter os emails 

cat <<EOF> /var/svn/repos/hook/post-commit
#!/bin/bash

# Envio de e-mail apos commit

REPOS="$1"
REV="$2"
AUTHOR="$(svnlook author $REPOS -r $REV)"
DATE="$(svnlook date $REPOS -r $REV)"
MESSAGE="$(svnlook log $REPOS -r $REV)"
FILES_CHANGE="$(svnlook changed $REPOS -r $REV)"

sh envio.email.sh

EOD

