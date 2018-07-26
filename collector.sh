#!/usr/bin/env bash

# 1st argument: argument is the directory to be scanned without trailing slash and without spaces
# 2nd argument: full path to the csv file
# 3rd argument: serial number of the disk - Not yet automated
#
# Example
# ./collector.sh /run/media/user/Portable_Disk_1 ~/Docuemnts/Archive.csv
#

disk_name=$(basename $1)

# Automatic serial number read does not work
# serial_number=$(lsblk -n -o SERIAL `mount| grep "$1" | awk 'NR==1{print $1}'|sed 's/[0-9]*//g'`)
serial_number=$3

echo "path=$1"
echo "disk name=$disk_name"
echo "serial_number=$serial_number"
echo "csv path=$2"

# Write the header of the CSV file if the file does not exist
if [ ! -f $2 ]; then
    echo "\"Disk Serial Number\",\"File MD5 Checksum\",\"Drive Name\",\"File Path\"" > $2
fi

find "$1" -type f -print0 | xargs -0 md5sum | sed -r "s/^([0-9a-f]{32})  (.*)/\"$serial_number\",\"\1\",\"$disk_name\",\"\2\"/" >> $2