source common.sh
nodejs
component=cart



echo Configuration Cart Systemd Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log && systemctl daemon-reload &>>/tmp/cart.log
statuscheck

echo Starting card service
systemctl start cart &>>/tmp/cart.log && systemctl enable cart &>>/tmp/cart.log
statuscheck