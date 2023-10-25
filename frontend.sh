source common.sh
display "install nginx"
dnf install nginx -y &>>${LOG}
statusmsg

display "start nginx"
systemctl start nginx &>>${LOG}
statusmsg

display "enable nginx"
systemctl enable nginx &>>${LOG}
statusmsg

display "remove old html content"
rm -rf /usr/share/nginx/html/* &>>${LOG}
statusmsg

display " download website content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
statusmsg

cd /usr/share/nginx/html/

display "unzip the content at location"
unzip /tmp/frontend.zip &>>${LOG}
statusmsg

display "copy the config file to its location"
cp ${configs}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
statusmsg

display "Restart nginx"
systemctl restart nginx &>>${LOG}
statusmsg


