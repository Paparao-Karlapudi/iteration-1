source common.sh

display "Install Redis"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
statusmsg

display "Enable Redis"
dnf module enable redis:remi-6.2 -y &>>${LOG}
statusmsg

display "Install Redis"
dnf install redis -y &>>${LOG}
statusmsg

display "Update Listening Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>${LOG}
statusmsg

display "Start and Enbale Redis"
systemctl enable redis &>>${LOG}
systemctl start redis &>>${LOG}
