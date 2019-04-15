#!/bin/bash

cd ~/CMPE132Kali/password_results
unshadow /etc/passwd /etc/shadow > mypasswd
john mypasswd
