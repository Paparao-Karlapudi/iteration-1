source common.sh

display "disable previous mysql"
dnf module disable mysql -y
statusmsg

