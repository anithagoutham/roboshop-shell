# this script is only for dry

statuscheck() {
 if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
 fi
}

nodejs() {
  echo setting NodeJS repos
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/${component}.log
    statuscheck

    echo installing NodeJS
    yum install nodejs -y&>>/tmp/${component}.log
    statuscheck

    id roboshop &>>/tmp/${component}.log
    if [ $? -ne 0 ]; then
       echo Adding Application User
       useradd roboshop &>>/tmp/${component}.log
       statuscheck
    fi

    echo Downloading Application Content
    curl -s -L -o /tmp/${component}.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/${component}.log
    cd /home/roboshop &>>/tmp/${component}.log
    statuscheck

    echo Cleaning old application content
    rm -rf ${component} &>>/tmp/${component}.log
    statuscheck

    echo Extract Application Archieve
    unzip /tmp/${component}.zip &>>/tmp/${component}.log && mv ${component}-main ${component} &>>/tmp/${component}.log && cd /home/roboshop/${component} &>>/tmp/${component}.log
    statuscheck

    echo Installing NodeJS dependencies
    npm install &>>/tmp/${component}.log
    statuscheck

    echo Configuration ${component} Systemd Service
    mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service &>>/tmp/${component}.log && systemctl daemon-reload &>>/tmp/${component}.log
    statuscheck

    echo Starting component service
    systemctl start ${component} &>>/tmp/${component}.log && systemctl enable ${component} &>>/tmp/${component}.log
    statuscheck


}

