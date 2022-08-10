statuscheck() {
 if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
 fi
}
echo setting NodeJS repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/temp/cart.log
  statuscheck

  echo installing NodeJS
  yum install nodejs -y &>>/temp/cart.log
  statuscheck

  id roboshop &>>/temp/cart.log
  if[ $? -ne 0 ]; then
     echo Adding Application User
     useradd roboshop &>>/temp/cart.log
     statuscheck
  fi



echo Downloading Application Content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/temp/cart.log
cd /home/roboshop &>>/temp/cart.log
statuscheck

echo Cleaning old application content
rm -rf cart &>>/temp/cart.log
statuscheck

echo Extract Application Archieve
unzip /tmp/cart.zip &>>/temp/cart.log && mv cart-main cart &>>/temp/cart.log && cd cart &>>/temp/cart.log
statuscheck

echo Installing NodeJS Independencies
npm install &>>/temp/cart.log
statuscheck

echo Configuration Cart Systemd Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/temp/cart.log && systemctl daemon-reload &>>/temp/cart.log
statuscheck

echo Starting card service
systemctl start cart &>>/temp/cart.log && systemctl enable cart &>>/temp/cart.log
statuscheck