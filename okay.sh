echo "=========================================================="

instances=($(startsap -c | grep -Po "\d+$"))
abap=$(sapcontrol -nr ${instances[0]} -function GetSystemInstanceList | grep ABAP)
java=$(sapcontrol -nr ${instances[0]} -function GetSystemInstanceList | grep J2EE)

if [ -n "$abap" ] && [ -n "$java" ]; then
    output="ABAP and JAVA"
elif [ -n abap ]; then
    output="r3"
elif [ -n java ]; then
    output="j2ee"
else
    output="Error"
fi

echo SID: $(whoami)
echo System Type: $output

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

echo "Output of command: sapcontrol -nr <instance numbers> -function StopService"
echo
for output in "${stopServiceOutput[@]}"
do
    echo $output
done

echo "Output of command: cleanipc <instance number> remove all"
echo
for output in "${cleanIpcOutput[@]}"
do
    echo $output
done




