# this script is only for dry

statuscheck() {
 if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
 fi
}

download(){
 echo Downloading Application Content
     curl -s -L -o /tmp/${component}.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/${component}.log
    statuscheck
}

nodejs() {
  echo setting NodeJS repos
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${Log}
    statuscheck

    echo installing NodeJS
    yum install nodejs -y &>>${Log}
    statuscheck

    id roboshop &>>${log}
    if [ $? -ne 0 ]; then
       echo Adding Application User
       useradd roboshop &>>${Log}
       statuscheck
    fi

    download

    echo Cleaning old application content
    cd /home/roboshop &>>${Log} && rm -rf ${component} &>>${Log}
    statuscheck

  echo Extract Application Archieve
    unzip -o /tmp/${component}.zip &>>${Log} && mv ${component}-main ${component} &>>${Log} && cd /home/roboshop/${component} &>>${Log}
    statuscheck

    echo Installing NodeJS dependencies
    npm install &>>${Log}
    statuscheck

    echo Configuration ${component} Systemd Service
    mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service &>>${Log} && systemctl daemon-reload &>>${Log}
    statuscheck

    echo Starting component service
    systemctl start ${component} &>>${Log} && systemctl enable ${component} &>>${Log}
    statuscheck
}
user_id=$(id -u)
if [ $user_id -ne 0 ]; then
  echo -e "\e[31m u should ru the script as root user or sudo\e[0m"
  exit 1
fi

Log=/tmp/${component}.log
rm -f ${Log}
