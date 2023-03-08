#!/bin/bash

##how i added the script to linux path
###sudo mkdir bin
###sudo mv LinuxStatus.sh bin
###export PATH="$HOME/bin:$PATH"

echo "Welcome, "$USER"!"
echo "The current date is: " $(date +%Y-%m-%d)
echo "The Linux version is "$(uname -r)
declare -r days=7

Processes() {
 ps
}

Memory() {
 echo "Memory status:"
 free -h
 echo "Clearing..."
 sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"
 echo "Done!"
}

HDD() {
 df -h
 cd /var/log
 sudo find . -type f -mtime +$days -exec rm {} \;
}

Apache() {

if which apache2 > /dev/null; then
  apache2 -v
else
  echo "Apache is not installed"
fi
}

Menu() {
echo "Menu View: "
echo "Option 1: List the running process"
echo "Option 2: Check the momery status and free memory in RAM"
echo "Option 3: Check the hard disk status and free memory in HDD"
echo "Option 4: Check if apache is installed"
echo "Option 5: Exit"
read -p "Please choose an option: " option
if [ $option -eq 1 ]; then
 Processes
 subMenu
fi
if [ $option -eq 2 ]; then
  Memory
  subMenu
fi
if [ $option -eq 3 ]; then
  HDD
  subMenu
fi
if [ $option -eq 4 ]; then
   Apache
   subMenu
fi
if [ $option -eq 5 ]; then
  exit 0
fi
}
subMenu(){
echo "1. Back"
echo "2. Update"
echo "3. Exit"
read -p "Please choose an option: " suboption
if [ $suboption -eq 1 ]; then
 Menu
fi
if [ $suboption -eq 2 ]; then
 clear
 clear
 Menu
fi
if [ $suboption -eq 3 ]; then
 exit 0
fi
}
for arg in "$@"
do
  case $arg in
    p) Processes ;;
    r) Memory ;;
    h) HDD ;;
    a) Apache ;;
    *) echo "Invalid Input" ;;
  esac
  done
if [[ $# == 0 ]]; then
Menu
fi
