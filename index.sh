#! /bin/bash

if ! test -d ./logs
then
    mkdir logs
fi

read -p "Enter the software name you want to install:" name

case $name in
    "git"|"mysql"|"java"|"docker"|"neo4j")
        source "./softwares/${name}.sh"
        start
    ;;
    "redis"|"node"|"nginx"|"mongo")
        read -p "Enter ${name} version:" version
        if [ -z ${version} ]
        then
            echo "Please enter version"
        else
            source "./softwares/${name}.sh"
            start "${version}"
        fi
    ;;
    *)
        echo "Not supported yet"
    ;;
esac

