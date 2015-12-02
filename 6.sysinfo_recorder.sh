#!/bin/bash

crontab -l | grep -v '^#' > mycrontab

echo "1 * * * * echo -n \$(date +%Y-%m-%d-%H-%M) >>/tmp/cpu.log && top -n 1|grep \"Cpu\" >>/tmp/cpu.log " >> mycrontab
echo "* */1 * * * cat /tmp/cpu.log >> /tmp/cpu_old.log && rm /tmp/cpu.log" >>mycrontab
echo "* * */1 * * rm /tmp/cpu_old.log" >>mycrontab

crontab mycrontab
