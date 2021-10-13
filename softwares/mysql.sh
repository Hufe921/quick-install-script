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
            yumSource="mysql80-community-release-el7-3.noarch.rpm"
        fi
        
        wget yumSource >> "https://repo.mysql.com/${rpmName}" >> ${curLogDir} &&
        yum localinstall ${rpmName} >> ${curLogDir} &&
        yum install mysql-community-server >> ${curLogDir} &&
        systemctl start mysqld >> ${curLogDir} &&
        systemctl enable mysqld
        
        if [ $? -eq 0 ]
        then
            echo "mysql installed successfully"
        else
            echo "mysql install failed,please check the logs/mysql.${curDate}.log"
        fi
    fi
}