#!/bin/bash

# Instalação do SVN Server 
# Johni Douglas Marangon

#apt-get update

#apt-get install subversion apache2 libapache2-svn subversion-tools apache2-utils

#SVN_CONF=/var/svn/conf
#mkdir -p ${SVN_CONF}
#chown -R www-data:www-data ${SVN_CONF}			
#chmod -R 770 ${SVN_CONF}

#SVN_REPOS=/var/svn/repos
#mkdir -p ${SVN_REPOS}			
#chown -R www-data:www-data ${SVN_REPOS}			
#chmod -R 770 ${SVN_REPOS}			

#svnadmin create --fs-type fsfs ${SVN_REPOS}/MyRepo
#chown -R www-data:www-data ${SVN_REPOS}/MyRepo
#chmod -R 770 ${SVN_REPOS}/MyRepo



#/etc/apache2/mods-available/dav_svn.conf
#<Location /svn >
#        DAV svn
        
#		SVNParentPath /var/svn/repos
#        SVNListParentPath On
#		AuthType Basic
#        AuthName "Microsys SVN Repositorio"
		
#        AuthUserFile /var/svn/conf/passwd
#	AuthzSVNAccessFile /var/svn/conf/authz
		#<LimitExcept GET PROPFIND OPTIONS REPORT>
#			Require valid-user
		#</LimitExcept>       
		
#</Location>


#touch ${SVN_CONF}/passwd
#touch ${SVN_CONF}/authz

#htpasswd -b -c /var/svn/conf/passwd admin admin




#apt-get install mysql-server-5.5 php5 php5-mysql phpmyadmin






