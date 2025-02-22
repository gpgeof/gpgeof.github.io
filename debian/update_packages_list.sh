#!/bin/bash

ORGANIZATIONS=("Dirack" "Dirack")
REPOS=("ShellUnity" "Shellinclude")
PACKAGENAMES=("shellunity" "shellinclude")

echo "Check repositories for updates"

for i in $(seq 0 1 1)
do

    echo "Package: ${PACKAGENAMES[$i]}"

    # Verificar a última atualização
    LAST_RELEASE=$(curl https://api.github.com/repos/${ORGANIZATIONS[$i]}/${REPOS[$i]}/releases/latest -s | sed -n '/tag_name/p' | cut -d":" -f2 | cut -d'"' -f2)

    echo "Latest Release Found: ${LAST_RELEASE}"

    # Tem esta última release?
    if [ ! -f "${PACKAGENAMES[$i]}_${LAST_RELEASE##*v}_all.deb" ]
    then
        wget "https://github.com/${ORGANIZATIONS[$i]}/${REPOS[$i]}/releases/download/${LAST_RELEASE}/${PACKAGENAMES[$i]}_${LAST_RELEASE}.deb.zip"
        unzip "${PACKAGENAMES[$i]}_${LAST_RELEASE}.deb.zip"
    fi

    if ls *.deb.zip
    then
        rm *.deb.zip
    fi
done

echo "Scan packages with dpkg"
# This is a script to update the Packages list with the following command
dpkg-scanpackages -m . /dev/null > Packages