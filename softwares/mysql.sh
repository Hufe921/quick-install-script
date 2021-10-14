start(){
    curVersion=$(mysql -V)
    if [ $? -eq 0 ]
    then
        echo "mysql has been installed (${curVersion})"
    else
        echo "mysql Installing..."
        curDir=$(pwd)
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/mysql.${curDate}.log"
        curRelease=$(uname --kernel-release)
        rpmName="mysql80-community-release-el8-1.noarch.rpm"
        if [[ ${curRelease} == *el7* ]]
        then
            rpmName="mysql80-community-release-el7-3.noarch.rpm"
        fi
        
        wget "https://repo.mysql.com/${rpmName}" >> ${curLogDir} &&
        yum -y localinstall ${rpmName} >> ${curLogDir} &&
        yum -y install mysql-community-server >> ${curLogDir} &&
        systemctl start mysqld >> ${curLogDir} &&
        systemctl enable mysqld
        
        if [ $? -eq 0 ]
        then
            curVersion=$(mysql -V)
            echo "mysql(${curVersion}) installed successfully"
        else
            echo "mysql install failed,please check the logs/mysql.${curDate}.log"
        fi
    fi
}