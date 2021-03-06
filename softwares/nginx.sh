start(){
    curVersion=$(nginx -v)
    if [ $? -eq 0 ]
    then
        echo "nginx has been installed (${curVersion})"
    else
        echo "nginx installing..."
        curDir=$(pwd)
        curDate=$(date +%Y%m%d%H%M%S)
        curLogDir="../logs/nginx.${curDate}.log"
        nginxPackage="nginx-$1.tar.gz"
        
        yum -y install gcc &&
        yum -y install pcre pcre-devel &&
        yum -y install zlib zlib-devel &&
        yum -y install openssl openssl-devel &&
        wget "http://nginx.org/download/${nginxPackage}" &&
        tar -zxvf ${nginxPackage} &&
        rm -rf ${nginxPackage} &&
        cd "./nginx-$1" &&
        pwd &&
        ./configure --with-http_v2_module --with-http_ssl_module --with-stream --with-http_stub_status_module &&
        make &&
        make install &&
        cd /usr/local/nginx/sbin/ &&
        ./nginx 2>> ${curLogDir} &&
        ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
        
        if [ $? -eq 0 ]
        then
            echo "nginx installed successfully"
        else
            echo "nginx install failed,please check the logs/nginx.${curDate}.log"
        fi
    fi
}