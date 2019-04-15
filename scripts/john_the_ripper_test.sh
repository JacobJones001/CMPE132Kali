#!/bin/bash

cd ~/CMPE132Kali/password_results

if [[ $1 == "clearpot" ]]; then
	rm ~/.john/john.pot
fi

if ! [ -f time.txt ]; then
	touch time.txt
fi


unshadow /etc/passwd /etc/shadow > mypasswd
{ echo -e "\n\nTime for default parameters" ; } >>time.txt
{ time john mypasswd 2> john.stderr; } 2>> time.txt
echo -e "\nJohn the Ripper Output:"
john mypasswd --show
# cat ~/.john/john.pot
