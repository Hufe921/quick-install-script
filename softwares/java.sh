start(){
    curVersion=$(java -version)
    if [ $? -eq 0 ]
    then
        echo "java has been installed (${curVersion})"
    else
        echo "java Installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/java.${curDate}.log"
        
        yum -y install java
        
        if [ $? -eq 0 ]
        then
            curVersion=$(java -version)
            echo "java(${curVersion}) installed successfully"
        else
            echo "java install failed,please check the logs/java.${curDate}.log"
        fi
    fi
}