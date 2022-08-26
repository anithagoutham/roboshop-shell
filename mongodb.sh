source common.sh

component=mongodb

echo setup yum repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
statuscheck

echo install mongodb
yum install -y mongodb-org &>>${Log}
statuscheck

echo start mongodb service
systemctl enable mongod &>>${Log} && systemctl start mongod &>>${Log}
statuscheck

## update the listen configuration

download

echo extract the schema files
cd /tmp  && unzip -o mongodb.zip &>>${Log}
statuscheck

echo load schema
cd mongodb-main
mongo < catalogue.js
mongo < users.js &>>${Log}
statuscheck






