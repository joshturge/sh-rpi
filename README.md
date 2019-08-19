
# Auto SSH into Raspberry Pi

This script scans all available ip addresses on a network (0 to 255) using [nmap](https://nmap.org/). From the output of the nmap command this script will then use [grep](https://www.gnu.org/software/grep/) to search for a specific pattern, the pattern being a MAC address of a Raspberry Pi. Once the script has found the MAC address it will then get the ip accosiated with that MAC address, the script will then try and ssh into the device.

This script is pretty useful when the Raspberry Pi's ip isn't static, this saves you the hassle of having to run a nmap scan yourself or setting up a monitor and keyboard on the Raspberry Pi and getting the ip that way.

## Usage

This script is pretty easy to use, just supply the MAC address of the Pi you want to ssh into with command line args like:

```bash
ssh-rpi.sh MM:MM:MM:SS:SS:SS
```

Or if you're feeling a bit lazy set the variable `RPI_MAC` in your `.bashrc` file with the Pi's MAC address. This will save you having to type out the MAC address everytime. If you want to connect to a different Pi than the one set in your `.bashrc` you can with ease. The script will treat command line args with a higher importance than environment variables.

### Dependencies

- `nmap>=7.70-3`
