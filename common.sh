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
