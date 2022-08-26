set -e


if [ -z "$mysql_password" ]; then
  echo -e "\e[33m env variable mysql_password is missing \e[0m"
  exit 1
fi

echo setup yum repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>${Log}
statuscheck

echo install mysql
yum install mysql-community-server -y &>>${Log}
statuscheck

echo start mysql service
systemctl enable mysqld &>>${Log} && systemctl start mysqld &>>${Log}
statuscheck

echo "show_databases;" | mysql -uroot -p$mysql_password&>>${Log}
if [ $? -ne 0 ]; then
  echo changing default password
  Default_Passowrd=$(grep 'A TEMPORARY PASSWORD' /var/log/mysql.log | awk '{print $NF}')
  echo "alter user 'root'@'localhost' identified with mysql_native_password by '$mysql_password';" | mysql --connect-expired-password -uroot
  -p${Default_Password} &>>${Log}
  statuscheck
fi

echo "show plugins;" | mysql -uroot -p$mysql_password | grep validate_password &>>{Log}
if [ $? -eq 0 ]; then
  echo remove password validate plugin
  echo "uninstall plugin validate_password;" | mysql -uroot -p$mysql_password
  statuscheck
fi

download

echo "extract & load schema"
cd /tmp &>>${Log} &&  unzip -o mysql.zip &>>${Log} && cd mysql-main &>>${Log} && mysql -u root -pRoboShop@1 <shipping.sql &>>${Log}
statuscheck
