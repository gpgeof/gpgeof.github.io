#!/bin/bash


# Verificar a última atualização
LAST_RELEASE=$(curl https://api.github.com/repos/Dirack/ShellUnity/releases/latest -s | sed -n '/tag_name/p' | cut -d":" -f2 | cut -d'"' -f2)

# Tem esta última release?
if [ ! -f "shellunity_${LAST_RELEASE##*v}_all.deb" ]
then
    wget "https://github.com/Dirack/ShellUnity/releases/download/${LAST_RELEASE}/shellunity_${LAST_RELEASE}.deb.zip"
    unzip "shellunity_${LAST_RELEASE}.deb.zip"
fi

if ls *.deb.zip
then
    rm *.deb.zip
fi

# Baixar atualização da shellunity
#https://github.com/Dirack/ShellUnity/releases/latest

# This is a script to update the Packages list with the following command
dpkg-scanpackages -m . /dev/null > Packages
