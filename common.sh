configs=$(pwd)
LOG=/tmp/project1.log

statusmsg()
{
if [ $? -eq 0 ]; then
echo -e "SUCCESS"
else
  echo -e "\e[31mFAILURE\e[0m"
  echo "refer ${LOG} for more details"
  exit 1
fi
}

display()
{
  echo -e "\e[35m$1\e[0m"
}


appli_prereq()
{

  display "Adding Roboshop User"
  id roboshop &>>${LOG}
  if [ $? -ne 0 ]
  then
  useradd roboshop
  fi
  statusmsg

  display "making the directory"
  mkdir -p /app

  display "Download the code"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${LOG}
  rm -rf /app/*
  statusmsg

  cd /app

  display "Unzip the code at app location"
  unzip /tmp/${component}.zip &>>${LOG}
  statusmsg

  cd /app


}

systemd_service()
{
  display "Copy the Systemd Service file"
  cp ${configs}/files/${component}.service /etc/systemd/system/${component}.service &>>${LOG}
  statusmsg

  display "Enable Load and Starting Service"
  systemctl daemon-reload ${component} &>>${LOG}
  systemctl enable ${component} &>>${LOG}
  systemctl start ${component} &>>${LOG}
}

schema_load()
{
  display "Setup mongodb client repo"
  cp ${configs}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
  statusmsg

  display "Install mongodb repo"
  dnf install mongodb-org-shell -y &>>${LOG}
  statusmsg

  display "Load Schema"
  mongo --host mongodb-dev.pappik.online </app/schema/${component}.js &>>${LOG}
  statusmsg

}

Nodejs()
{
  display "Setup Nodejs Repo"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
    statusmsg

    display "Install Nodejs"
    dnf install nodejs -y &>>${LOG}
    statusmsg

    appli_prereq

   display "Install the dependencies"
   npm install &>>${LOG}
   statusmsg

    systemd_service

    schema_load
}

Maven()
{
  display " Install Maven"
  dnf install maven -y &>>${LOG}
  statusmsg

  appli_prereq

display "Mvn Clean Package"
mvn clean package &>>${LOG}
statusmsg


mv target/${component}-1.0.jar ${component}.jar &>>${LOG}

systemd_service

display " Install Mysql Client "
  dnf install mysql -y &>>${LOG}
  statusmsg

display " Load the Schema "
 mysql -h mysql-dev.pappik.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${LOG}
  statusmsg

display " Restarting Shipping Service "
  systemctl restart shipping &>>${LOG}
  statusmsg

}