#!/bin/bash

cd ~/CMPE132Kali/zip_results
echo $1 > TestZip.txt
zip -e JohnTest.zip TestZip.txt # enter password
zip2john JohnTest.zip > ZipJohnHash.txt
john ZipJohnHash.txt
john --show ZipJohnHash.txt

