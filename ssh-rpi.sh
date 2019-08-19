#!/bin/bash

# Check if a mac address has been supplied
if [ $# -eq 0 ]; then

    printf "No arguments supplied, checking env for RPI_MAC\n"
    
    if [[ -z $RPI_MAC ]]; then
        printf "RPI_MAC has not been set either\nExiting...\n"
        exit 2
    else
        mac_addr=$RPI_MAC
    fi
else
    mac_addr=$1
fi

for i in {1..5}
    do
        # This will run nmap with TCP ACK discovery on port 22 (The popular ssh port).
        # From nmap's output we grab the host name and host ip.
        rpi=($(sudo nmap -sn -PA22 192.168.1.0/24 | grep -E "$mac_addr" -B 2 | head -1))

        # Check if $rpi has returned an array of strings, if so we then ssh into the raspberry pi
        if (( ${#rpi[@]} )); then
            # Get the host name of device
            host_name=${rpi[4]}

            # Get the ip of the host and remove the brackets surrounding it
            host_ip=${rpi[5]:1:-1}

            printf "Logging into %s\n" $host_name
            ssh $host_name@$host_ip
            exit 0
        fi

        printf "Couldn't find a host with that mac address, retrying...\n"
        continue

    done

printf "Couldn't find a host with that mac address, exiting...\n"
exit 1