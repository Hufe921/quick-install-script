start(){
    curVersion=$(java -version)
    if [ $? -eq 0 ]
    then
        echo "java has been installed (${curVersion})"
    else
        echo "java installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/java.${curDate}.log"

        yum -y install java 2>> ${curLogDir}

        if [ $? -eq 0 ]
        then
            java -version &&
            echo "java installed successfully"
        else
            echo "java install failed,please check the logs/java.${curDate}.log"
        fi
    fi
}