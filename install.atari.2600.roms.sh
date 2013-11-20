#!/bin/bash
# executa com super usuario


__DIR=/usr/games
__PATH=Atari2600

__DIR_TMP=/tmp/roms

__DIR_PATH_INSTALATION=${__DIR}/${__PATH}


[[ ! -d ${__DIR_PATH_INSTALATION} ]] && mkdir -p ${__DIR_PATH_INSTALATION}
[[ -d ${__DIR_TMP} ]] && rm -rf ${__DIR_TMP} && mkdir -p ${__DIR_TMP} 


[ -f ${__DIR_TMP}/Atari2600_A-E.zip  ] && rm ${__DIR_TMP}/Atari2600_A-E.zip
wget -N http://www.atariage.com/2600/emulation/RomPacks/Atari2600_A-E.zip -P ${__DIR_TMP}


[ -f ${__DIR_TMP}/Atari2600_F-J.zip  ] && rm ${__DIR_TMP}/Atari2600_F-J.zip
wget -N http://www.atariage.com/2600/emulation/RomPacks/Atari2600_F-J.zip -P ${__DIR_TMP}


[ -f ${__DIR_TMP}/Atari2600_K-P.zip  ] && rm ${__DIR_TMP}/Atari2600_K-P.zip
wget -N http://www.atariage.com/2600/emulation/RomPacks/Atari2600_K-P.zip -P ${__DIR_TMP}


[ -f ${__DIR_TMP}/Atari2600_Q-S.zip  ] && rm ${__DIR_TMP}/Atari2600_Q-S.zip
wget -N http://www.atariage.com/2600/emulation/RomPacks/Atari2600_Q-S.zip -P ${__DIR_TMP}


[ -f ${__DIR_TMP}/Atari2600_T-Z.zip  ] && rm ${__DIR_TMP}/Atari2600_T-Z.zip
wget -N http://www.atariage.com/2600/emulation/RomPacks/Atari2600_T-Z.zip -P ${__DIR_TMP}


unzip ${__DIR_TMP}/Atari2600_A-E.zip -d ${__DIR_PATH_INSTALATION}
unzip ${__DIR_TMP}/Atari2600_F-J.zip -d ${__DIR_PATH_INSTALATION}
unzip ${__DIR_TMP}/Atari2600_K-P.zip -d ${__DIR_PATH_INSTALATION}
unzip ${__DIR_TMP}/Atari2600_Q-S.zip -d ${__DIR_PATH_INSTALATION}
unzip ${__DIR_TMP}/Atari2600_T-Z.zip -d ${__DIR_PATH_INSTALATION}



[[ -d ${__DIR_TMP} ]] && rm -rf ${__DIR_TMP} && mkdir -p ${__DIR_TMP} 

echo "Os jogos foram salvos no diretorio ${__DIR_PATH_INSTALATION}"






