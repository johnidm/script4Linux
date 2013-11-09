#!/bin/bash 

# Envio de e-mail usnado o sendMail - http://caspian.dotconf.net/menu/Software/SendEmail/
# Johni Douglas Marangon
# Nov/2013

# verifica se o svnlook esta instalado

PROJECT="$1"
REVISION="$2"

AUTHOR="$(svnlook author $REPOS -r $REV)"
DATE="$(svnlook date $REPOS -r $REV)"
LOG="$(svnlook log $REPOS -r $REV)" # mensagem do commit
FILES_CHANGE="$(svnlook changed $REPOS -r $REV)"

FROM="mailer@microsys.inf.br"

TO="johni.douglas.marangon@gmail.com"

SUBJECT="${AUTHOR} comitou no projeto ${PROJECT}"

SMTP="smtp.microsys.inf.br:25"

USER="mailer@microsys.inf.br"  
PASSWORD="f4o01t62" 

MESSAGE="Mensagem de commit" 

sendEmail -f ${FROM} -t ${TO} -u ${SUBJECT} -m ${MESSAGE} -s ${SMTP} -xu ${USER} -xp ${PASSWORD}

