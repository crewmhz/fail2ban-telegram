#!/bin/bash

# Sends text messages using Telegram
# to alert webmaster of banning.

# Require one argument, one of the following
# start
# stop
# ban
# unban
# Optional second argument: Ip for ban/unband


# Display usage information
function show_usage {
  echo "Usage: $0 action <ip>"
  echo "Where action start, stop, ban, unban"
  echo "and IP is optional passed to ban, unban"
  exit
}


# Send notification
function send_msg {
  apiToken='YOUR TOKEN'
  chatId='YOUR ID'
  url="https://api.telegram.org/bot$apiToken/sendMessage"

  curl -s -X POST $url -d chat_id=$chatId -d text="$1"
  exit
}


# Check for script arguments
if [ $# -lt 1 ]
then
  show_usage
fi


# Take action depending on argument
if [ "$1" = 'start' ]
then
  msg='Sistem+keamanan+Fail2ban+diaktifkan.'
  send_msg $msg
elif [ "$1" = 'stop' ]
then
  msg='Sistem+keamanan+Fail2ban+dimatikan.'
  send_msg $msg
elif [ "$1" = 'ban' ]
then
  msg=$([ "$2" != '' ] && echo "Fail2ban+mendeteksi+dan+memblok+ip+$2" || echo 'Fail2ban+mendeteksi+dan+memblok+ip+an+ip.' )
  send_msg $msg
elif [ "$1" = 'unban' ]
then
  msg=$([ "$2" != '' ] && echo "Fail2ban+membuka+banned+pada+ip+$2" || echo "Fail2ban+mendeteksi+dan+membuka+banned+pada+ip+an+ip." )
  send_msg $msg
else
  show_usage
fi
