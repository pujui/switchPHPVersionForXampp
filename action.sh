#!/bin/bash

source xamppConfig

phpVersion=""

function getPHPVersion(){

    echo -e ""
    echo -e "Choice your php version:"
    phpVersion=$(ls | grep 'XAMPP_' | sed -e 's/XAMPP_//g')

    phpAry=()
    
    echo -e "\e[1;37m"
    while read -r line
    do
        phpAry+=($line)
        echo -e "  $line"
    done <<< "$phpVersion"
    echo -e "\e[0;37m"
    
    while true; do
        echo -e ""
        read -p "please input> " setPHPVersion
        for key in "${!phpAry[@]}";
        do
            if [ "$setPHPVersion" = "${phpAry[$key]}" ]; then
                phpVersion="$setPHPVersion"
                return 1
            elif [ "$setPHPVersion" = "q" ]; then
                return 0
            fi
        done
        echo -e "Please again, because your input version is error!!!"
    done
}

function switchXamppPHP(){

    getPHPVersion
    check=$?
    if [ $check -eq 0 ]; then
        echo -e ""
        return 0
    fi

    echo -e ""
    echo -e "\e[1;37m"
    echo -e "Your decide is $phpVersion"
    echo -e ""
    echo -e "Please waiting...switch apache setting"
    commandString="$gitPath/XAMPP_$phpVersion/apache $xamppPath"
    cp -r $commandString

    echo -e ""
    echo -e "Please waiting...switch php version"
    commandString="$gitPath/XAMPP_$phpVersion/php $xamppPath"
    cp -r $commandString

    echo -e ""
    echo -e "========================"
    $xamppPath/php/php.exe -v
    echo -e "========================"
    echo -e "Switch finish!"
    echo -e "\e[0;37m"
}

while true; do
    echo -e ""
    echo -e "Commands:"
    echo -e "========================"
    echo -e "s: switch xampp php version\t"
    echo -e "q: quit"
    echo -e ""
    read -p "please input> " command
    if [ "$command" = "s" ]; then
        switchXamppPHP
    elif [ "$command" = "2" ]; then
        echo -e "Commands:"
    elif [ "$command" = "3" ]; then
        echo -e "Commands:"
    elif [ "$command" = "q" ]; then
        exit 0
    else
        exit 0
    fi
done
