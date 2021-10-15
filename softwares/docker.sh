start(){
    curVersion=$(docker -v)
    if [ $? -eq 0 ]
    then
        echo "docker has been installed (${curVersion})"
    else
        echo "docker Installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/mongo.${curDate}.log"
        
        yum -y install yum-utils &&
        yum-config-manager --add-repo "https://download.docker.com/linux/centos/docker-ce.repo" &&
        yum -y install docker-ce docker-ce-cli containerd.io &&
        systemctl start docker
        
        if [ $? -eq 0 ]
        then
            curVersion=$(docker -v)
            echo "docker(${curVersion}) installed successfully"
        else
            echo "docker install failed,please check the logs/docker.${curDate}.log"
        fi
    fi
}