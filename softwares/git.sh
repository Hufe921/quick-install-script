start(){
    curVersion=$(git --version)
    if [ $? -eq 0 ]
    then
        echo "git has been installed (${curVersion})"
    else
        echo "git Installing..."
        curDate=$(date +%Y%m%d%H%M%S)

        yum -y install git > "./logs/git.${curDate}.log"
        
        if [ $? -eq 0 ]
        then
            echo "git installed successfully"
        else
            echo "git install failed,please check the logs/git.${curDate}.log"
        fi
    fi
}