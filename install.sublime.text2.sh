#!/bin/bash

# 32
http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.tar.bz2

# 64
http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2

wget ${URL} -P /tmp

tar jxvf  -C ${DirInstalacao}

chown -R root:root ${DirInstalacao}
chmod -R +r ${DirInstalacao}

# criar o startes

# limpar os diretorios
