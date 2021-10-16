start(){
    curVersion=$(redis-server -v)
    if [ $? -eq 0 ]
    then
        echo "redis has been installed (${curVersion})"
    else
        echo "redis installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/redis.${curDate}.log"
        redisPackage="redis-$1.tar.gz"

        yum -y install gcc-c++ &&
        wget "https://download.redis.io/releases/${redisPackage}" &&
        tar -zxvf ${redisPackage} &&
        rm -rf ${redisPackage} &&
        cd "redis-$1" &&
        make MALLOC=libc &&
        make install &&
        ./utils/install_server.sh 2>> ${curLogDir}

        if [ $? -eq 0 ]
        then
            echo "redis installed successfully"
        else
            echo "redis install failed,please check the logs/redis.${curDate}.log,if redis version > 6.0.8,please try update ./install_server.sh"
        fi
    fi
}