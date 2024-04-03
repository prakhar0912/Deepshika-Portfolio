#!/bin/bash
abap=$(sapcontrol -nr 00 -function GetSystemInstanceList | grep ABAP | grep GREEN)
java=$(sapcontrol -nr 00 -function GetSystemInstanceList | grep J2EE | grep GREEN)

echo $host

if [ -n abap ] && [ -n java ]; then
    echo $whoami ABAP and JAVA
elif [ -n abap ]; then
    echo $whoami ABAP
elif [ -n java ]; then
    echo $whoami JAVA
else
    echo ERROR
fi
