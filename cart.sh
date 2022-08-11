source common.sh
nodejs

echo Downloading Application Content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
cd /home/roboshop &>>/tmp/cart.log
statuscheck

echo Cleaning old application content
rm -rf cart &>>/tmp/cart.log
statuscheck

echo Extract Application Archieve
unzip /tmp/cart.zip &>>/tmp/cart.log && mv cart-main cart &>>/tmp/cart.log && cd cart &>>/tmp/cart.log
statuscheck

echo Installing NodeJS Independencies
npm install &>>/tmp/cart.log
statuscheck

echo Configuration Cart Systemd Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log && systemctl daemon-reload &>>/tmp/cart.log
statuscheck

echo Starting card service
systemctl start cart &>>/tmp/cart.log && systemctl enable cart &>>/tmp/cart.log
statuscheck