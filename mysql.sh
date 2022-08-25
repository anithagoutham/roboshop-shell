set -e

curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo

yum install mysql-community-server -y

systemctl enable mysqld
systemctl start mysqld

DEFAULT_PASWORD = $(grep "A TEMPORARY PASSWORD" /var/log/mysql.log | awk '{print $NF}')




echo mysql password = $mysql_password
echo "alter user 'root'@'localhost' identified with mysql_native_password by '$mysql_password';" | mysql --connect-expired-password -uroot -p${default}

echo "uninstall plugin validate_password;" | mysql -uroot -p$mysql_password


 curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

 cd /tmp
 unzip mysql.zip
 cd mysql-main
 mysql -u root -pRoboShop@1 <shipping.sql
