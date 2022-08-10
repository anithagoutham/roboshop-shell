source common.sh

nodejs

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