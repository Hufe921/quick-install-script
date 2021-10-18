start(){
    jenkinsDir=$(find /var -name jenkins)
    if [ ${#jenkinsDir} != 0 ]
    then
        echo "jenkins has been installed"
    else
        echo "jenkins installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/jenkins.${curDate}.log"
        rpmName=jenkins-$1-1.1.noarch.rpm

        wget http://pkg.jenkins-ci.org/redhat-stable/${rpmName} &&
        yum -y install epel-release &&
        yum -y install daemonize &&
        rpm -ivh ${rpmName} &&
        service jenkins start 2>> ${curLogDir}

        if [ $? -eq 0 ]
        then
            echo "jenkins installed successfully"
        else
            echo "jenkins install failed,please check the logs/jenkins.${curDate}.log"
        fi
    fi
}