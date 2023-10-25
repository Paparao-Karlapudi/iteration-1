source common.sh

display "Setup Nodejs Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
statusmsg

display "Install Nodejs"
dnf install nodejs &>>${LOG}
statusmsg

display "Adding Roboshop User"
useradd roboshop
statusmsg

display "making the directory"
mkdir /app

display "Download the code"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
statusmsg

cd /app

display "Unzip the code at app location"
unzip /tmp/catalogue.zip &>>${LOG}
statusmsg

display "Install the dependencies"
npm install &>>${LOG}
statusmsg

display "Copy the Systemd Service file"
cp ${configs}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
statusmsg

display "Enable Load and Starting Service"
systemctl daemon-reload catalogue
systemctl enable catalogue
systemctl restart catalogue

display "Setup mongodb client repo"
cp ${configs}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
statusmsg

display "Install mongodb repo"
dnf install mongodb-org-shell -y &>>${LOG}
statusmsg

dispaly "Load Schema"
mongo --host mongodb-dev.pappik.online </app/schema/catalogue.js &>>${LOG}
statusmsg