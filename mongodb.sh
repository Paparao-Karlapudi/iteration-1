source common.sh

display "copy mongodb repo file"
cp ${configs}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
statusmsg

display "Install Mongodb"
dnf install mongodb-org -y &>>${LOG}
statusmsg

display "Start and Enable Mongodb"
systemctl start mongodb
systemctl enable mongodb
statusmsg

display "Change mongodb listening address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
statusmsg

display "Restarting Mongodb"
systemctl start mongodb
