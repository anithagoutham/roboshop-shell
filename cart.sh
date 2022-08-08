

echo setting NodeJS repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/temp/cart.log
echo $?

echo installing NodeJS
yum install nodejs -y &>>/temp/cart.log
echo $?

echo Adding Application User
useradd roboshop &>>/temp/cart.log
echo $?

echo Downloading Application Content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/temp/cart.log
cd /home/roboshop &>>/temp/cart.log
echo $?

echo Cleaning old application content
rm -rf cart &>>/temp/cart.log
echo $?


echo Extract Application Archieve
unzip /tmp/cart.zip &>>/temp/cart.log
mv cart-main cart &>>/temp/cart.log
cd cart &>>/temp/cart.log
echo $?


echo Installing NodeJS Independencies
npm install &>>/temp/cart.log
echo $?

echo Configuration Caart System Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/temp/cart.log
systemctl daemon-reload &>>/temp/cart.log
echo $?

echo Starting card service
systemctl start cart &>>/temp/cart.log
systemctl enable cart &>>/temp/cart.log
echo $?