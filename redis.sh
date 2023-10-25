source common.sh

display "Install Redis"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
statusmsg

display ""