start(){
    curVersion=$(mongo -version)
    if [ $? -eq 0 ]
    then
        echo "mongo has been installed (${curVersion})"
    else
        echo "mongo Installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/mongo.${curDate}.log"
        repoName="/etc/yum.repos.d/mongodb-org-$1.repo"
        
        echo "[mongodb-org-4.2]" >> ${repoName} &&
        echo "name=MongoDB Repository" >> ${repoName} &&
        echo "baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/$1/x86_64/" >> ${repoName} &&
        echo "gpgcheck=1" >> ${repoName} &&
        echo "enabled=1" >> ${repoName} &&
        echo "gpgkey=https://www.mongodb.org/static/pgp/server-$1.asc" >> ${repoName} &&
        yum -y install mongodb-org &&
        service mongod start
        
        if [ $? -eq 0 ]
        then
            echo "mongo installed successfully"
        else
            echo "mongo install failed,please check the logs/mongo.${curDate}.log"
        fi
    fi
}