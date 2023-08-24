#!/bin/bash


#XXXXXX#
# VARS #
#XXXXXXX
HOST=s3.amazonaws.com
REGEX='(?<=<Endpoint>).*?(?=<\/Endpoint>)'
REGXION='(?<=s3-).*?(?=.amazonaws.com)'
skH='-s -k -H'


#XXXXXXXXXXXXXXXXXX#
#      USAGE       #
#XXXXXXXXXXXXXXXXXX#
if [ $# -eq 0 ] || [ $# -gt 2 ];  then
    echo -e "ＡＷＳ３ＡＲＣＨ"
    echo -e "________________\n"
    echo "Usage 1: $0 domain"
    echo "Usage 2: $0 -r domains_file"

    exit 1
fi

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo -e "ＡＷＳ３ＡＲＣＨ"
    echo -e "________________\n"
    echo "  -h, --help: Show this message"
    echo -e "  -r: Read domains from file."
    echo -e "\tDomains must NOT contain extensions such as [.com|.es|.net|.org]"

    exit 0
fi

if [ "$1" == "-r" ] && [ $# -lt 2 ]; then
    echo -e "ＡＷＳ３ＡＲＣＨ"
    echo -e "________________\n"
    echo "Usage: $0 -r domains_file"
    echo -e "\tDomains must NOT contain extensions such as [.com|.es|.net|.org]"
        
    exit 1
fi


####################
#       MAIN       #
####################
if [ "$1" == "-r" ]; then
    input_file="$2"

    while IFS= read -r line; do
        curl -s "https://${HOST}/$line" | grep -oP ${REGEX} > /dev/null
        if [ $? -eq 0 ]; then
            printf "Bucket %-10s >> " "$line"
            curl ${skH} "Host: $line.${HOST}" "https://${HOST}" | grep -oP ${REGEX}
        else
            echo "S3 Bucket $line does NOT exist"
        fi
    done < "$input_file"
else
    curl -s "https://${HOST}/$1" | grep -oP ${REGEX} > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "ＡＷＳ３ＡＲＣＨ"
        echo -e "________________\n"
        printf "Bucket %-10s >> " "$1"
        curl ${skH} "Host: $1.${HOST}" "https://${HOST}" | grep -oP ${REGEX}
    else
        echo "S3 Bucket $1 does NOT exist"
        exit 1
    fi
fi
