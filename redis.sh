source common.sh

common = redis


echo setup yum repo
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${log}
statuscheck

echo install redis
yum install redis-6.2.7 -y &>>${log}
statuscheck

# update listen ip

systemctl enable redis &>>${log} && systemctl start redis &>>${log}
statuscheck