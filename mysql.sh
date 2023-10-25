source common.sh

display "disable previous mysql"
dnf module disable mysql -y &>>${LOG}
statusmsg

display "Copy MySql repo to desired location"
cp ${configs}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
statusmsg

display "Install MySql Server"
dnf install mysql-community-server -y &>>${LOG}
statusmsg

display "Enable and Start Mysql"
systemctl enable mysqld &>>${LOG}
systemctl start mysqld  &>>${LOG}
statusmsg

display "Change Root Password for Mysql"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${LOG}
statusmsg
