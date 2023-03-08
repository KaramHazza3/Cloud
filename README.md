#For the first script
First sudo chmod +x LunixStatus.sh is required to make it executable, then i was in the home/iace directory and i made a directory named bin using (sudo mkdir bin), then i moved the .sh file to bin using (sudo mv LinuxStatus.sh bin), Finally i did modify the environment variable PATH to include the $HOME/bin directory at the beginning of the search path using 
(export PATH="$HOME/bin:$PATH"), the advantage of this job is to execute any programs in that directory (bin) from anywhere in the terminal.




#For the second script
First i ran this command crontab -e which contains a list of commands that are scheduled to run at specific times to edit the crontab file.
Then i added a new line at the end of the file: 0 0 * * * /bin/StaticWeb.sh
it means that it should be able to run at midnight everyday.
I saved the crontab file.
Then i verified that the cronjob was added successfully using: crontab -l
which should display the current crontab file, plus the my new line.
