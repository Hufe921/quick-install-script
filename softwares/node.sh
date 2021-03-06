start(){
    curVersion=$(node -v)
    if [ $? -eq 0 ]
    then
        echo "node has been installed (${curVersion})"
    else
        echo "node installing..."
        curDir=$(pwd)
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/node.${curDate}.log"
        nodePackage="node-v$1-linux-x64.tar.gz"

        wget "https://nodejs.org/dist/v$1/${nodePackage}" &&
        tar -zxvf ${nodePackage} &&
        rm -rf ${nodePackage} &&
        ln -s ${curDir}/${nodePackage%%.tar.gz}/bin/node /usr/local/bin/node &&
        ln -s ${curDir}/${nodePackage%%.tar.gz}/bin/npm /usr/local/bin/npm &&
        ln -s ${curDir}/${nodePackage%%.tar.gz}/bin/npx /usr/local/bin/npx &&
        node -v  2>> ${curLogDir}

        if [ $? -eq 0 ]
        then
            echo "node installed successfully"
        else
            echo "node install failed,please check the logs/node.${curDate}.log"
        fi
    fi
}