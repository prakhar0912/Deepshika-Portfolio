instances=($(startsap -c | grep -Po "\d+$"))
abap=$(sapcontrol -nr ${instances[0]} -function GetSystemInstanceList | grep ABAP)
java=$(sapcontrol -nr ${instances[0]} -function GetSystemInstanceList | grep J2EE)

if [ -n "$abap" ] && [ -n "$java" ]; then
    whoami
    echo ABAP and JAVA
    output="ABAP and JAVA"
elif [ -n abap ]; then
    output="r3"
elif [ -n java ]; then
    echo $whoami JAVA
    output="j2ee"
else
    echo ERROR
    output="Error"
fi

# stopCommandOutput=$(stopsap -help "$output")

declare -a stopServiceOutput=()
for inst in "${instances[@]}"
do
    stopServiceOutput+=("$(sapcontrol -nr ${inst} -function GetSystemInstanceList)")
done

declare -a cleanIpcOutput=()
for inst in "${instances[@]}"
do
    cleanIpcOutput+=("$(cleanipc ${inst} remove all)")
done


