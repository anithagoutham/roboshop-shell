# this script is only for dry

statuscheck() {
 if [ $? -eq 0]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
 fi
}

nodejs() {

  echo setting NodeJS repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/temp/cart.log
  statuscheck

  echo installing NodeJS
  yum install nodejs -y &>>/temp/cart.log
  statuscheck

  id roboshop &>>/temp/cart.log
  if[ $? -ne 0 ]; then
     echo Adding Application User
     useradd roboshop &>>/temp/cart.log
     statuscheck
  fi
}