#!/bin/bash

cd ~/CMPE132Kali/password_results

if ! [ -f time.txt ]; then
	touch time.txt
fi

TEST_JOHN_MODE=default
TEST_JOHN_OPTIONS= 

unshadow /etc/passwd /etc/shadow > mypasswd
{ echo -e "password, mode, time" ; } > time.csv # csv header
TIMEFORMAT='%lU' # change time output format

TEST_RUN_JOHN () {
END=$1
for ((i=1;i<=END;i++)); do
	if [[ $2 == "clearpot" ]]; then
		rm ~/.john/john.pot
	fi
	{ time john $TEST_JOHN_OPTIONS mypasswd 2> john.stderr; } 2> time_temp.txt
	TEST_JOHN_TIME=$(cat time_temp.txt) 	# may need to clean up number to work in graph
	TEST_JOHN_PASS=$(john --show mypasswd  | grep -oP '(?<=root:).*(?=:0:0)') # specific to root
	echo $TEST_JOHN_PASS, default, $TEST_JOHN_TIME >> time.csv
done
}
TEST_RUN_JOHN 2 $1

echo -e "\nJohn the Ripper Output:"
john mypasswd --show
# cat ~/.john/john.pot
