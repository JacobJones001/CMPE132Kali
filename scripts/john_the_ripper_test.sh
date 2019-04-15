#!/bin/bash

if [[ $1 == "clearpot" ]]; then
	rm ~/.john/john.pot
fi

cd ~/CMPE132Kali/password_results
unshadow /etc/passwd /etc/shadow > mypasswd
john mypasswd
echo -e "\nJohn the Ripper Output:"
john mypasswd --show
# cat ~/.john/john.pot
