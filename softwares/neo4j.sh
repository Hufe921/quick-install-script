start(){
    curVersion=$(neo4j --version)
    if [ $? -eq 0 ]
    then
        echo "neo4j has been installed (${curVersion})"
    else
        echo "neo4j installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/neo4j.${curDate}.log"
        repoName="/etc/yum.repos.d/neo4j.repo"

        rpm --import https://debian.neo4j.com/neotechnology.gpg.key &&
        echo "[neo4j]" >> ${repoName} &&
        echo "name=Neo4j Yum Repo" >> ${repoName} &&
        echo "baseurl=http://yum.neo4j.com/stable" >> ${repoName} &&
        echo "enabled=1" >> ${repoName} &&
        echo "gpgcheck=1" >> ${repoName} &&
        yum -y install neo4j &&
        service neo4j start 2>> ${curLogDir}

        if [ $? -eq 0 ]
        then
            curVersion=$(neo4j --version)
            echo "neo4j(${curVersion}) installed successfully"
        else
            echo "neo4j install failed,please check the logs/neo4j.${curDate}.log"
        fi
    fi
}