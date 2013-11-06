#!/bin/bash

# How to test this script
# ./check.run.root.sh
# sudo ./check.run.root.sh
# su && ./check.run.root.sh 

FALSE=0
TRUE=1

run_is_root() {
	

	if [[ $EUID -ne 0 ]]; then
	 	return $FALSE 	
	else
		return $TRUE
	fi

	#if [ "$(id -u)" != "0" ]; then
	#	return $FALSE
	#else
	#	return $TRUE	
	#fi

	
	#if [ "$(whoami)" != "root" ]; then
	#	return $FALSE
	#else
	#	return $TRUE	
	#fi

	
}

check_root() {

	if run_is_root; then
		echo "Nao esta executando como root"
	fi
}


check_root


