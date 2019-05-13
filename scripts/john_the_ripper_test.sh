#!/bin/bash

cd ~/CMPE132Kali/password_results

if ! [ -f time.txt ]; then
	touch time.txt
fi



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
	
	if [[ $TEST_JOHN_MODE == "descrypt" ]]; then
		TEST_JOHN_PASS=$(john --show mypasswd  | grep -oP '(?<=root:).*(?=:0:0)') # specific to root
	fi
	if [[ $TEST_JOHN_MODE == "sha512crypt" ]]; then
		TEST_JOHN_PASS=$(john --show mypasswd  | grep -oP '(?<=Harman:).*(?=:998:998)') # specific to root
	fi
	echo $TEST_JOHN_PASS, $TEST_JOHN_MODE, $TEST_JOHN_TIME >> time.csv
done
}
TEST_JOHN_MODE=descrypt
TEST_JOHN_OPTIONS=--format=descrypt
TEST_RUN_JOHN $1 $2

TEST_JOHN_MODE=sha512crypt
TEST_JOHN_OPTIONS=--format=sha512crypt
TEST_RUN_JOHN $1 $2

TEST_JOHN_MODE=descrypt
TEST_JOHN_OPTIONS=--format=descrypt
TEST_RUN_JOHN 1

echo -e "\nJohn the Ripper Output:"
john mypasswd --show
# cat ~/.john/john.pot
