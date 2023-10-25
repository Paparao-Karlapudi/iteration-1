statusmsg()
{
if [ $? -eq 0 ]; then
echo -e "SUCCESS"
else
  echo -e "\e[31mFAILURE\e[0m"
  echo "refer project1.log for more details"
  exit 1
fi
}

display()
{
  echo "\e[36m$1\e[0m"
}

display "install nginx"
dnf install nginx -y
statusmsg
