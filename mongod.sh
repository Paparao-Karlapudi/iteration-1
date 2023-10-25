source common.sh

display "copy mongodb repo file"
cp ${configs}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
statusmsg

display "Install Mongodb"
dnf install mongodb-org -y &>>${LOG}
statusmsg

display "Change mongodb listening address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
statusmsg

display "Enable Mongodb"
systemctl enable mongod
statusmsg

display "Restarting Mongodb"
systemctl start mongod
