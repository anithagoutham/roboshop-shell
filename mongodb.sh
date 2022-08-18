source common.sh

component = mongodb

echo setup yum repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
statuscheck

echo install mongodb
yum install -y mongodb-org &>>${log}
statuscheck

echo start mongodb service
systemctl enable mongod &>>${log} systemctl start mongod &>>${log}
statuscheck

## update the listen configuration

download

echo " extract the schema files"
cd /tmp && unzip -0 mongodb.zip &>>${log}
statuscheck

echo load schema
cd mongodb-main && mongo < catalogue.js &>>${log} && mongo < users.js &>>${log}
statuscheck






