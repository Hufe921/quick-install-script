start(){
    curVersion=$(redis-server -v)
    if [ $? -eq 0 ]
    then
        echo "redis has been installed (${curVersion})"
    else
        echo "redis Installing..."
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/redis.${curDate}.log"
        redisPackage="redis-$1.tar.gz"
        
        yum -y install gcc-c++ >> ${curLogDir} &&
        wget "https://download.redis.io/releases/${redisPackage}" >> ${curLogDir} &&
        tar -zxvf ${redisPackage} &&
        rm -rf ${redisPackage} &&
        cd "redis-$1" &&
        make MALLOC=libc >> ${curLogDir} &&
        make instal >> ${curLogDir} &&
        ./utils/install_server.sh >> ${curLogDir}
        
        if [ $? -eq 0 ]
        then
            echo "redis installed successfully"
        else
            echo "redis install failed,please check the logs/redis.${curDate}.log"
        fi
    fi
}