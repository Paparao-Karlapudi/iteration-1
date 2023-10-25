source common.sh
component=shipping

display " Install Maven"
dnf install maven -y &>>${LOG}
statusmsg

appli_prereq

systemd_service
