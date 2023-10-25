source common.sh

display "Configure Yum repos for Script"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${LOG}
statusmsg

display "Configure Yum Repos for Rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${LOG}
statusmsg

display "Install Rabbitmq"
dnf install rabbitmq-server -y &>>${LOG}
statusmsg

display "Enable and Start Rabbitmq"
systemctl enable rabbitmq-server &>>${LOG}
systemctl start rabbitmq-server  &>>${LOG}
statusmsg

display "Adding user and Permissions to Rabbitmq"
rabbitmqctl add_user roboshop roboshop123 &>>${LOG}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
statusmsg
