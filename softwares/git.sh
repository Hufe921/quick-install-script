start(){
    curVersion=$(git --version)
    if [ $? -eq 0 ]
    then
        echo "git has been installed (${curVersion})"
    else
        echo "git installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/git.${curDate}.log"

        yum -y install git  2>> ${curLogDir}

        if [ $? -eq 0 ]
        then
            curVersion=$(git --version)
            echo "git(${curVersion}) installed successfully"
        else
            echo "git install failed,please check the logs/git.${curDate}.log"
        fi
    fi
}