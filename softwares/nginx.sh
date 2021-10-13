start(){
    curVersion=$(nginx -v)
    if [ $? -eq 0 ]
    then
        echo "nginx has been installed (${curVersion})"
    else
        echo "nginx Installing..."
        curDir=$(pwd)
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="./logs/nginx.${curDate}.log"
        nginxPackage="nginx-$1.tar.gz"
        
        yum -y install gcc >> ${curLogDir} &&
        yum install -y pcre pcre-devel >> ${curLogDir} &&
        yum install -y zlib zlib-devel >> ${curLogDir} &&
        yum install -y openssl openssl-devel >> ${curLogDir} &&
        wget "http://nginx.org/download/${nginxPackage}" >> ${curLogDir} &&
        tar -zxvf ${nginxPackage} &&
        rm -rf ${nginxPackage} &&
        cd "./nginx-$1" &&
        ./configure >> ${curLogDir} &&
        make >> ${curLogDir} &&
        make install >> ${curLogDir} &&
        ./sbin/nginx
        
        if [ $? -eq 0 ]
        then
            echo "nginx installed successfully"
        else
            echo "nginx install failed,please check the logs/nginx.${curDate}.log"
        fi
    fi
}