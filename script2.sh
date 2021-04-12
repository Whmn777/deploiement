#!/bin/bash

MD5_DEST=$(md5sum /etc/apache2/sites-available/000-default.conf | awk '{print$1}')
MD5_SRC=$(md5sum 000-default.conf | awk '{print$1}')

if [ "$MD5_DEST" != "$MD_5SRC" ]
then
	echo "On écrase la conf apache"
	cp 000-default.conf /etc/apache2/sites-available/000-default.conf
	fi

	service apache2 restart
