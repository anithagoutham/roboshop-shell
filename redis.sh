source common.sh

component=redis


echo setup yum repo
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${log}
statuscheck

echo install redis
yum install redis-6.2.7 -y &>>${Log}
statuscheck

# update listen ip

echo start redis service
systemctl enable redis &>>${Log} && systemctl start redis &>>${Log}
statuscheck